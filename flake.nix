{
  description = "meshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    wrappers = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    packages.x86_64-linux = rec {
      quickshell = inputs.wrappers.wrappers.quickshell.wrap {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;

        configDir = ./.;
      };
      default = quickshell;
    };
  };
}
