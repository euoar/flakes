# powerline-config/flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    in
    {
      overlays.default = final: prev: {
        powerlineShellHook = ''
          # Configure powerline-go for dev shells
          function _update_ps1() {
            PS1="$(${final.powerline-go}/bin/powerline-go -theme gruvbox -hostname-only-if-ssh -error $?)"
          }
          if [ "$TERM" != "linux" ]; then
            PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
          fi
        '';
      };

      packages = forAllSystems (system: 
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = pkgs.powerline-go;
        });
    };
}