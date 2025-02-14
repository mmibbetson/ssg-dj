# SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
# SPDX-FileContributor: Matthew Mark Ibbetson
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  lib,
  gitSupport ? true,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  installShellFiles,
}:

rustPlatform.buildRustPackage rec {
  pname = "ssg-dj";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "mmibbetson";
    repo = "ssg-dj";
    rev = "v${version}";
    sha256 = "sha256-D7ccY8Vq8grUwjojPzVlpBPmyU1iUwt41gYAs4rOzaI=";
  };

  cargoHash = "sha256-+QHCYQ/0Kl4cp1nyq2nCFMKNz37p8IUhq7LdF62DVRk=";

  nativeBuildInputs = [
    pkg-config
    installShellFiles
  ];
  buildInputs = [ ];

  outputs = [
    "out"
    "man"
  ];

  postInstall =
    ''
      installManPage man/ssg-dj.1 man/ssg-dj-new.1 man/ssg-dj-rename.1
      installShellCompletion \
        --bash completions/ssg-dj.bash \
        --fish completions/ssg-dj.fish \
        --zsh completions/_ssg-dj
    '';

  meta = with lib; {
    description = "A simple, minimal, and flexible command line utility for organising plaintext files.";
    homepage = "https://mmibbetson.github.io/software/ssg-dj";
    changelog = "https://github.com/mmibbetson/ssg-dj/CHANGELOG.md";
    license = licenses.gpl3Plus;
    mainProgram = "ssg-dj";
    maintainers = with maintainers; [
      mmibbetson
    ];
    platforms = platforms.unix ++ platforms.windows;
  };
}
