{ pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
    config.allowUnsupportedSystem = false;
  };
in
{
  programs.chromium = {
    enable = true;
    package = unstable.google-chrome;
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
      { id = "bfnaelmomeimhlpmgjnjophhpkkoljpa"; } # phantom wallet
      { id = "hlepfoohegkhhmjieoechaddaejaokhf"; } # refined github
      { id = "gppongmhjkpfnbhagpmjfkannfbllamg"; } # wappalyzer
      { id = "jabopobgcpjmedljpbcaablpmlmfcogm"; } # whatfont
    ];
    commandLineArgs = [ "--disable-features=WebRtcAllowInputVolumeAdjustment" ];
  };
}
