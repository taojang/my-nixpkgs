{ }:

let
  pkgs = import <nixpkgs> {};
  python = import ./requirements.nix { inherit pkgs; };
in pkgs.buildEnv {

  name = "zalando-stups-cli";

  paths = [
    python.packages."stups"
    python.packages."stups-cli-support"
    python.packages."stups-piu"
    python.packages."stups-senza"
    python.packages."stups-berry"
    python.packages."stups-zign"
    python.packages."stups-pierone"
    python.packages."stups-fullstop"
    python.packages."stups-kio"
    python.packages."zalando-aws-cli"
    python.packages."zalando-kubectl"
    python.packages."zalando-deploy-cli"
    python.packages."zmon-cli"
  ];
}
