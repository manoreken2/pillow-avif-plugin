# pillow-avif-plugin quick hack to output 10bit HDR10PQ AVIF

## how to build and install on Windows

- install miniforge
- install VS2019
- install git for windows
- install TortoiseGit
- install MSYS2 and add C:\MSYS\usr\bin to PATH environment variable
- download https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win64/nasm-2.15.05-win64.zip , unzip onto C:\apps\NASM and add D:\apps\NASM to PATH environment variable.
- on Administrator miniforge prompt, pip install meson
- build and install quick hack pillow to support R16G16B16 https://github.com/manoreken2/Pillow-R16G16B16/tree/main/winbuild
- on Administrator miniforge prompt, cd to this directory, cd winbuild and python build_prepare.py
- cd winbuild/build and build_dep_all.cmd and build_pillow_avif_plugin.cmd
- cd to this directory and python -m pip install -e .
- pip list should show pillow-avif-plugin

## how to write HDR10PQ AVIF file

```
from PIL import Image
from pillow_avif import AvifImagePlugin
from pillow_avif import _avif
import cv2

# read R16G16B16 png file
imCV = cv2.imread("a.png", cv2.IMREAD_UNCHANGED)
imCV = cv2.cvtColor(imCV, cv2.COLOR_BGR2RGB)

print("imCV {0} {1}".format(imCV.dtype, imCV.shape))

im = Image.fromarray(imCV, mode="R16G16B16")
im.save("out.avif", quality=100, range="full", subsampling="4:4:4", depth=10, color_primaries=9, transfer_characteristics=16, matrix_coefficients=0)
```

## encoding options

## "qmin"

encoding quality. integer. Quality range is 0 to 63

encoder->minQuantizer

| value | meanings |
|-----:|-----------|
|     0| AVIF_QUANTIZER_BEST_QUALITY |
|     63| AVIF_QUANTIZER_WORST_QUALITY |

## "qmax"

encoding quality. integer. Quality range is 0 to 63

encoder->maxQuantizer

| value | meanings |
|-----:|-----------|
|     0| AVIF_QUANTIZER_BEST_QUALITY |
|     63| AVIF_QUANTIZER_WORST_QUALITY |

## "speed"

encoding speed. slower should make for a better quality. integer.

| value | meanings |
|-----:|-----------|
|    -1| AVIF_SPEED_DEFAULT |
|     0| AVIF_SPEED_SLOWEST |
|    10| AVIF_SPEED_FASTEST |

## "codec"

default is "auto".
encoder availability depends on the build settings of libav1f.

| value | meanings |
|-----:|-----------|
|   "auto" | auto |
|   "dav1d" | dav1d |
|   "libgav1" | libgav1 |
|   "aom" | aom |
|   "rav1e" | rav1e |
|   "svt" | svt |


## "range"

| value | meanings |
|-----:|-----------|
|     "full" | full quantization range image. ex. ST 2084 PQ requires it |
|     "limited" | limited quantization range image. |

## "subsampling"

| value | meanings |
|-----:|-----------|
|     "4:4:4" | YCbCr 4:4:4 or lossless GBR encoding |
|     "4:2:2" | YCbCr422   |
|     "4:2:0" | YCbCr420   |
|     "4:0:0" | YCbCr400 |

## "depth"

color bitdepth. 8, 10 or 12

## "quality"

encoding quality, integer number ranging 0 to 100

| value | meanings |
|-----:|-----------|
|     0 | worst color encoding quality |
|     75 | default color encoding quality |
|     100 | best color encoding quality |

## "tile_rows_log2"

default is 0

## "tile_cols_log2"

default is 0

## "alpha_premultiplied"

if true, enc_options.alpha_premultiplied is AVIF_TRUE

## "autotiling"

if true, enc_options.autotiling is AVIF_TRUE

## "icc_bytes"

it is set to avifImageSetProfileICC()

## "exif_bytes"

is is set to avifImageSetMetadataExif()

## "xmp_bytes"

is is set to avifImageSetMetadataXMP

## "advanced"

follows pytuple. it is set to  avifEncoderSetCodecSpecificOption()

## "color_primaries"

| value | meanings |
|-----:|-----------|
|     1| BT.709, Rec.709 or sRGB |
|     2| Unspecified    |
|     9| BT.2020, Rec.2020 or Rec.2100 |
|     12| DCI P3 or SMPTE EG 432-1 |

## "transfer_characteristics"

| value | meanings |
|-----:|-----------|
|     1| BT.709 or Rec.709 |
|     2| Unspecified    |
|     6| BT.601  |
|     8| Linear |
|     13| sRGB |
|     14| BT.2020 10bit |
|     15| BT.2020 12bit |
|     16| ST 2084 PQ for Rec.2020 |
|     18| HLG |

## "matrix_coefficients"

| value | meanings |
|-----:|-----------|
|     0| Identity matrix for lossless encoding. Stores color as GBR |
|     1| BT.709 YCbCr |
|     2| Unspecified    |
|     6| BT.601 YCbCr (default for lossy encodings) |
|     8| YCgCo |
|     9| BT.2020 non-constant luminance, BT.2100 YCbCr |
|     10| BT.2020 constant luminance |
|     11| SMPTE ST 2085 YDzDx |
|     14| BT.2100 ICtCp |
