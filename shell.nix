with import <nixpkgs> {};
mkShell {
    buildInputs = [
        crystal
        shellcheck
    ];
    shellHook = ''
        . .shellhook
    '';
}
