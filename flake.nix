{
  description = "Sagyam's NixOS Configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
        ./system/blocky.nix
        ./system/boot.nix
        ./system/desktop.nix
        ./system/hardware.nix
        ./system/networking.nix
        ./system/services.nix
        ./system/study-lock.nix
        ./system/study-schedule.nix
        ./system/system-programs.nix
        ./system/users.nix
        ./system/virtualisation.nix

        # Home Manager integration
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "backup";
          home-manager.users.sagyam = import ./home/sagyam.nix;
        }
      ];
    };
  };
}
