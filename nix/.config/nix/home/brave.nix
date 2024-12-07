{ pkgs, inputs, ... }:
let
  unstable = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system};
in
{
  programs.chromium = {
    enable = true;
    package = unstable.brave;
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
