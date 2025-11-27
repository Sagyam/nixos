# flake.nix
{
    description = "Flake for seting up Vicinae";
    inputs = {
        vicinae.url = "github:vicinaehq/vicinae"; # tell Nixos where to get Vicinae
        ...
    };
    outputs = {
        nixpkgs,
        home-manager,
        vicinae, # enable the Output
    }: let
    system = "...";
    pkgs = nixpkgs.legacyPackages.${system};
    in {
        homeConfigurations."..." = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
                vicinae.homeManagerModules.default # enable Home Manager
                ...
            ];
        }
    }
}
