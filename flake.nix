{
  description = "Mu Programming Language";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      # Define the systems your flake supports
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      # Function to apply a function to each supported system
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f { pkgs = import nixpkgs { inherit system; }; });
    in
    {
      # Define development shells
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [
            zig          # Include the Zig compiler from nixpkgs
            lldb         # Useful for debugging
          ];
          shellHook = ''
            echo "Welcome to the Zig development shell!"
          '';
        };
      });
    };
}

