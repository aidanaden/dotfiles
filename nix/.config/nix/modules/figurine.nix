{
  stdenv,
  fetchFromGitHub,
  buildGoModule,
  lib,
}:
buildGoModule rec {
  name = "figurine";
  version = "0.5";

  src = fetchFromGitHub {
    owner = "arsham";
    repo = "figurine";
    rev = "v${version}";
    hash = "sha256-1q6Y7oEntd823nWosMcKXi6c3iWsBTxPnSH4tR6+XYs=";
  };

  vendorHash = "sha256-mLdAaYkQH2RHcZft27rDW1AoFCWKiUZhh2F0DpqZELw=";

  # installPhase = ''
  #   runHook preInstall
  #   mkdir -p $out/bin
  #   cp icat $out/bin
  #   runHook postInstall
  # '';
  meta = with lib; {
    homepage = "https://github.com/arsham/figurine";
    description = "Print your name in style";
    license = licenses.asl20;
    maintainers = with maintainers; [ironicbadger];
  };
}
