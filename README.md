# Apache NetBeans installers

NBPackage configuration and build files for the Codelerity / Gj IT installers for
[Apache NetBeans](https://netbeans.apache.org).

For more information see [https://www.codelerity.com/netbeans/](https://www.codelerity.com/netbeans/)

## Build

This repository contains configuration files for building an Inno Setup Windows
installer, Linux Deb packages (x64 / all), and Linux AppImages (x64 / Arm).

Before starting, make a build of NBPackage inside an `nbpackage` directory (or
download a [pre-release binary](https://github.com/neilcsmith-net/netbeans-tools/releases)).

Download a copy of the official Apache NetBeans binary zip release, and check against
the hash file in the repository.

Create a `dist` directory for output files.

TIP : pass `--verbose` with any execution of nbpackage to see all output from
external build tools.

### Build Inno Setup installer

You will require an installation of Inno Setup from [https://jrsoftware.org/isdl.php](https://jrsoftware.org/isdl.php).

The configuration files here are designed to build on Linux via an installation of
Inno Setup in Wine. Tweak the configuration file to point to the right place if building
on Windows.

Download the right Azul Zulu JDK into the `windows-x64-iss` directory, checking against
the Azul provided hash. To use a different JDK, update the configuration file.

Build the installer by running -

```
./nbpackage/bin/nbpackage --input netbeans-14-bin.zip --config windows-x64-iss/netbeans-windows-x64.properties --output dist/
```

### Build MacOS installer

You will require `swift`, `codesign` and `pkgbuild` installed on the system.

Download the right Azul Zulu JDK into the `macos-x64` directory, checking against the
Azul provided hash. To use a different JDK, update the configuration file.

Add your Apple developer IDs for code signing and installer signing to the
configuration file.

Build the installer by running -

```
./nbpackage/bin/nbpackage --input netbeans-14-bin.zip --config macos-x64/netbeans-macos-x64.properties --output dist/
```

### Build DEB packages

You will require `fakeroot`, `dpkg` and `dpkg-deb` on the system. If building
the `x64` package, download the right Azul Zulu JDK into the `linux-x64` directory
and check against the provided hash file.

The `all` architecture configuration in `linux-all` does not require any additional
downloads and builds a DEB that runs on any architecture with the system JDK.

Build the package by running eg. -

```
./nbpackage/bin/nbpackage --input netbeans-14-bin.zip --config linux-x64/netbeans-x64-deb.properties --output dist/
```

### Build AppImages

AppImages must be built on the architecture they are designed for. The Arm AppImage
can be run on the Raspberry Pi or similar, and must be built on an Arm device.

Download the x64 or Arm executable of [AppImageKit](https://github.com/AppImage/AppImageKit/releases/tag/13)
into the relevant directory, checking against the provided hash. AppImageKit is itself
an AppImage - make sure to mark it executable before continuing.

The x64 AppImage will use the same JDK as the DEB above. For Arm (Raspberry Pi)
download the relevant BellSoft Liberica JDK and check against BellSoft's provided
hash.

Build the AppImage by running eg. -

```
./nbpackage/bin/nbpackage --input netbeans-14-bin.zip --config linux-arm32/netbeans-arm-appimage.properties --output dist/
```

## Legal

These packages are provided without warranty, and under the licenses and terms of
the bundled software. Please make sure you're familiar with all terms before downloading.
Apache NetBeans is provided under the terms of the
[Apache Software License](https://github.com/apache/netbeans/blob/master/LICENSE).
Some of the packages include a build of OpenJDK - [Azul Zulu](https://www.azul.com/downloads/)
for x86_64, and [BellSoft Liberica](https://bell-sw.com/pages/downloads/) for Arm.
Please see terms and licenses linked for the relevant JDK.

Apache, Apache NetBeans and the Apache NetBeans logo are trademarks or registered
trademarks of the Apache Software Foundation. Azul and Azul Zulu are trademarks or
registered trademarks of Azul Systems, Inc. BellSoft and Liberica are trademarks
or registered trademarks of BellSoft Ltd. Java and OpenJDK are registered trademarks
of Oracle and/or its affiliates. All other trademarks are the property of their
respective holders and used here only for identification purposes.

