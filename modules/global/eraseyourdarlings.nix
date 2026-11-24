{ inputs, ... }:
{
  flake.nixosModules.eraseyourdarlings = {
    imports = [ inputs.eyd.nixosModules.default ];
    boot.initrd = {
      eyd.enable = true;
      eyd.keep = [
        # defaultKeep = []; has essentials,
        # so exhastive listing is unneeded
        "/home"

        "/var/lib/NetworkManager"
        "/var/lib/bluetooth"
        "/var/lib/sbctl"

        "/var/log/btmp"
        "/var/log/journal"
        "/var/log/lastlog"
        "/var/log/wtmp"
      ];
      eyd.retain = 3;
    };
  };
}
