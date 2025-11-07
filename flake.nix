{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    distro-grub-themes.url = "github:AdisonCavani/distro-grub-themes";
  };

  outputs = { self, nixpkgs, distro-grub-themes, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        distro-grub-themes.nixosModules.x86_64-linux.default
      ];
    };
  };
}
