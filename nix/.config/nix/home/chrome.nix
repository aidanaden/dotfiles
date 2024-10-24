{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.google-chrome;
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
