# Apache NetBeans macOS pkg

Partial support for macOS pkg is included in NBPackage PR https://github.com/apache/netbeans-tools/pull/49 This
just covers image creation. To build the installers -

1. Copy NetBeans binary zip and required JDK alongside configuration file.
2. Run `./nbpackage --input netbeans-13-bin.zip --config macos-x64-pkg.properties --image-only`.
3. Copy other files here into the created `Apache_NetBeans-13-macOS-app-pkg` and complete remaining work in there.
4. Inside `macos-launcher-src` run `swift build -c release --arch x86_64`.
5. Copy `.build/x86_64-apple-macosx/release/AppLauncher` as `Apache NetBeans.app/Contents/MacOS/netbeans`.
6. Run `./signBinaries.sh "<SIGNING_ID>" sandbox.plist` to sign all bundled binaries.
7. Run `codesign --force --timestamp --options=runtime --entitlements sandbox.plist -s "<SIGNING_ID>" -v Apache\ NetBeans.app` to sign the .app itself.
8. Run `pkgbuild --component Apache\ NetBeans.app --identifier "com.codelerity.netbeans" --version "13.0.0" --install-location "/Applications" --sign "<SIGNING_ID>" "Apache NetBeans 13.pkg"` to build the installer package.
9. If distributing, notarize and staple.

