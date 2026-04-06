{
  description = "enGL's nixos-config";

  outputs = {
    self,
    home-manager,
    nixpkgs,
    systems,
    ...
  } @ inputs: let
    lib = nixpkgs.lib // home-manager.lib;
    inherit (self) outputs;
    specialArgs = {inherit inputs outputs;};
    forAllSystems = lib.genAttrs (import systems);
  in {
    overlays = import ./overlays specialArgs;

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    nixosConfigurations = {
      pc = lib.nixosSystem {
        inherit specialArgs;
        modules = [./hosts/pc];
      };
      xps13 = lib.nixosSystem {
        inherit specialArgs;
        modules = [./hosts/xps13];
      };
    };

    homeConfigurations = {
      "mel3048@ewsowks1276" = lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = specialArgs;
        modules = [./home/mel3048/ewsowks1276.nix];
      };
    };
  };

  inputs = {
    auto-cpufreq.url = "github:AdnanHodzic/auto-cpufreq";
    auto-cpufreq.inputs.nixpkgs.follows = "nixpkgs";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland/0002f148c9a4fe421a9d33c0faa5528cdc411e62"; # pin till hyprbars is fixed

    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    hyprland-plugins.inputs.hyprland.follows = "hyprland";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    nixcord.url = "github:kaylorben/nixcord";
    nixcord.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    secrets.url = "git+ssh://git@github.com/englmaxi/nix-secrets.git?ref=main&shallow=1";

    sops-nix.url = "github:mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    stylix.inputs.nur.follows = "nur";

    systems.url = "github:nix-systems/default-linux";

    xremap.url = "github:xremap/nix-flake";
    xremap.inputs.nixpkgs.follows = "nixpkgs";
  };
}
