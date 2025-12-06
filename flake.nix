{
  description = "ZaneyOS Stable";

  inputs = {
    # Wir nutzen hier die offiziellen STABLE Branches
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11"; # Stable Version

    nvf.url = "github:notashelf/nvf";
    stylix.url = "github:danth/stylix/release-25.11"; # Passend zu Stable
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Quickshell ist auf Unstable oft kaputt, daher hier auskommentiert
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    antigravity-nix = {
      url = "github:jacopone/antigravity-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , nixvim
    , nix-flatpak
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      host = "meo";
      profile = "nvidia-laptop";
      username = "meo";

      mkNixosConfig = gpuProfile:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit username;
            inherit host;
            inherit profile;
          };
          modules = [
            ./hosts/${host}
            ./modules/core/overlays.nix
            ./profiles/${gpuProfile}
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };
    in
    {
      nixosConfigurations = {
        amd = mkNixosConfig "amd";
        nvidia = mkNixosConfig "nvidia";
        nvidia-laptop = mkNixosConfig "nvidia-laptop";
        amd-hybrid = mkNixosConfig "amd-hybrid";
        intel = mkNixosConfig "intel";
        vm = mkNixosConfig "vm";
      };
    };
}
