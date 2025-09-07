{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        libraries = with pkgs;[
          webkitgtk_4_1
          file
          xdo
          glib
          dbus
          openssl
          librsvg
          gdk-pixbuf
          libayatana-appindicator
          gtk4
          pkg-config
        ];

        packages = with pkgs; [
          webkitgtk_4_1
          file
          xdo
          glib
          dbus
          openssl
          librsvg
          gdk-pixbuf
          libayatana-appindicator
          gtk4
          pkg-config
          curl
          wget
          cargo
          cargo-edit
          nodejs
          rustc
          rustfmt
          cairo
          libsoup_3
          pango
          at-spi2-atk
          atkmm
          harfbuzz
          gobject-introspection
        ];
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = packages;
          # inherit nativeBuildInputs;              
         
          shellHook =
            ''
              export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH
            '';
        };
      });
}
