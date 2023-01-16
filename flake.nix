{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-22.11";

  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems' = nixpkgs.lib.genAttrs;
      forAllSystems = forAllSystems' supportedSystems;
      pkgsForSystem = system:
        import nixpkgs { inherit system; };
    in
      {
        packages = forAllSystems
          (system:
            let
              pkgs = pkgsForSystem system;
            in
              {
                default = pkgs.runit.overrideAttrs
                  (old:
                    {
                      src = ./.;
                      sourceRoot = "";
                    });
              }
          );

        devShells = forAllSystems
          (system:
            let
              pkgs = pkgsForSystem system;
            in
              {
                default = pkgs.mkShell {
                  nativeBuildInputs = with pkgs; [
                    gnumake
                    stdenv.cc stdenv.cc.libc stdenv.cc.libc.static
                    ronn
                  ];
                };
              }
          );
      };
}
