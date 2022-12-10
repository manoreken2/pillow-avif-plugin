# pillow-avif-plugin

This is a plugin that adds support for AVIF files until official support has been added (see [this pull request](https://github.com/python-pillow/Pillow/pull/5201)).

To register this plugin with pillow you will need to add `import pillow_avif` somewhere in your application.

## how to build on Windows

- install miniforge
- install VS2019
- install git for windows
- install TortoiseGit
- install MSYS2 and add C:\MSYS\usr\bin to PATH environment variable
- download https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win64/nasm-2.15.05-win64.zip , unzip onto C:\apps\NASM and add D:\apps\NASM to PATH environment variable.
- on Administrator miniforge prompt, pip install pillow meson
- on Administrator miniforge prompt, cd to this directory, cd winbuild and python build_prepare.py
- cd winbuild/build and build_dep_all.cmd and build_pillow_avif_plugin.cmd
- cd to this directory and python -m pip install -e .
- pip list should show pillow-avif-plugin

## encoding options

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
