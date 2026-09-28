# TTDecomp - TTComp Archive Decompression Tool

A tool to decompress files in the TTComp archive data format, commonly used by various applications.

## Original Source

This repository contains the original TTDecomp source code by Tony Lewis <tlewis@exelana.com> from [exelana.com](https://www.exelana.com/techie/c/ttdecomp.tgz).

**Original Author**: Tony Lewis  
**Original Source**: https://www.exelana.com/techie/c/ttdecomp.tgz  
**Project Page**: https://www.exelana.com/techie/c/ttdecomp.html  
**Version**: 1.0  
**License**: GNU General Public License v3.0

## Related Libraries

This implementation uses the following libraries from the Starcraft/Brood War Library (lawine):
- `implode.c` - PKWare DCL implode compression API implementation
- `common.h` - Common definitions
- `implode.h` - Header for implode compression

**Lawine Library**: http://code.google.com/p/lawine/  
**Lawine License**: GNU Lesser GPL

## Description

TTDecomp decompresses files identified by the Unix `file` command as "TTComp archive data". The TTComp format is used by various applications including:
- InstallShield 3.x
- Other applications using this compression format

Note: TTDecomp does not parse the internal content of the input file; it simply decompresses it into the output file. The output may need further processing depending on the archive structure.

## Building

### Standard Build

```bash
make
```

This builds the `ttdecomp` executable with standard optimization flags.

### Debug Build with Backtrace

```bash
make debug
```

Builds with debug symbols and backtrace support for debugging crashes.

### AddressSanitizer (ASAN) Build

```bash
make asan
```

Builds with AddressSanitizer enabled to detect memory errors.

### Undefined Behavior Sanitizer (UBSAN) Build

```bash
make ubsan
```

Builds with Undefined Behavior Sanitizer enabled to detect undefined behavior.

### Full Sanitization Build

```bash
make sanitize
```

Builds with both AddressSanitizer and Undefined Behavior Sanitizer enabled.

### Clean

```bash
make clean
```

Removes all object files and executables.

## Usage

```bash
./ttdecomp infile outfile
```

### Example

```bash
# Decompress a TTComp file
./ttdecomp input.ttc output.bin

# Decompress with timeout (5 seconds)
timeout 5 ./ttdecomp input.ttc output.bin
```

## Compression Algorithm

The compression algorithm is an example of Shannon-Fano coding, as described at:
http://en.wikipedia.org/wiki/Shannon%E2%80%93Fano_coding

The decompression is performed in `implode.c`, which is from the Starcraft/Brood War Library (lawine).

## Related Tools

Other utilities that handle TTComp archives include:
- i3comp (InstallShield 3.x Compression and Maintenance utility)
- lawine library
- PKZIP (for its own "inflate" method)
- STIX (for InstallShield 3)

If TTDecomp output is not directly usable, try these alternative tools.

## Platform Support

Successfully built on:
- Mac OS X 10.7 using XCode command line utilities
- Redhat Linux using GNU utilities
- Windows 7 using Visual Studio 2010

For Windows builds in Visual Studio:
1. Create a console application
2. Add all `.c` and `.h` files
3. Insert `#include "stdafx.h"` after the copyright commentary in `ttdecomp.c`

## Known Issues

- Some TTComp files may use a different variant that is not fully compatible with this implementation
- The tool may fail to decompress certain files due to format variations

## Modifications

This fork includes the following modifications to the original source:
- Added infinite loop protection in the `explode()` function (implode.c:603-606)
- Enhanced error messages for incompatible TTComp formats

## License

This software is licensed under the GNU General Public License version 3.0 (GPL-3.0).

See the [LICENSE](LICENSE) file for the full license text.

## References

1. Original ttdecomp by Tony Lewis: https://www.exelana.com/techie/c/ttdecomp.tgz
2. Lawine library: http://code.google.com/p/lawine/
3. Shannon-Fano coding: http://en.wikipedia.org/wiki/Shannon%E2%80%93Fano_coding
4. PKWare Compression Library documentation

## Contributing

Contributions are welcome! Please fork this repository and submit pull requests.

## Reporting Bugs

Report bugs to the original author: Tony Lewis <tlewis@exelana.com>

Or create an issue in this repository.
