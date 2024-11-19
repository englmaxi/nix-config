{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModule
  ];

  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';

  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/NetworkManager"
      "/var/lob/systemd/coredump"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  # TODO: remove this once we have a proper solution for this
  # see https://github.com/nix-community/impermanence/issues/229
  systemd.suppressedSystemUnits = ["systemd-machine-id-commit.service"];

  environment.systemPackages = [
    (pkgs.writeScriptBin "listNonPersistent" ''
      mntpoint=$(mktemp -d)
      mount "/dev/mapper/crypted" "$mntpoint" -o subvol=/
      trap 'umount $mntpoint; rm -rf $mntpoint' EXIT
      oldTransitId=$(sudo btrfs subvolume find-new "$mntpoint/root-blank" 9999999 | cut -f4 -d ' ')
      sudo btrfs subvolume find-new "$mntpoint/root" "$oldTransitId" |
        sed '$d' | cut -f 17 -d ' ' | sort | uniq |
          while read path; do
            path="/$path"
            if [ -L "$path" ]; then
              : # symbolic link
            elif [ -d "$path" ]; then
              : # directory
            else
              echo "$path"
            fi
          done
    '')
  ];

  programs.fuse.userAllowOther = true;

  system.activationScripts.persistent-dirs.text = let
    mkHomePersist = user:
      lib.optionalString user.createHome ''
        mkdir -p /persist/${user.home}
        chown ${user.name}:${user.group} /persist/${user.home}
        chmod ${user.homeMode} /persist/${user.home}
      '';
    users = lib.attrValues config.users.users;
  in
    lib.concatLines (map mkHomePersist users);

  boot.initrd.systemd.enable = lib.mkDefault true;
  boot.initrd.systemd.services.rollback = {
    description = "Rollback BTRFS root subvolume";
    wantedBy = ["initrd.target"];
    after = ["systemd-cryptsetup@crypted.service"];
    before = ["sysroot.mount"];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mntpoint=$(mktemp -d)
      mount "/dev/mapper/crypted" "$mntpoint" -o subvol=/
      trap 'umount $mntpoint; rm -rf $mntpoint' EXIT

      btrfs subvolume list -o "$mntpoint/root" |
        cut -f9 -d' ' |
        while read subvolume; do
          echo "deleting /$subvolume subvolume..."
          btrfs subvolume delete "$mntpoint/$subvolume"
        done &&
        echo "deleting /root subvolume..." &&
        btrfs subvolume delete "$mntpoint/root"

      echo "restore blank /root subvolume"
      btrfs subvolume snapshot "$mntpoint/root-blank" "$mntpoint/root"
    '';
  };
}
