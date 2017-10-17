# generated using pypi2nix tool (version: 1.8.0)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -r requirements.txt -V 3 -E which
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python3;
  };

  commonBuildInputs = with pkgs; [ which ];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python3-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs);
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "PyJWT" = python.mkDerivation {
      name = "PyJWT-1.5.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c9/2a/ffd27735280696f6f244c8d1b4d2dd130511340475a29768ed317f9eaf0c/PyJWT-1.5.3.tar.gz"; sha256 = "500be75b17a63f70072416843dc80c8821109030be824f4d14758f114978bae7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytest"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "JSON Web Token implementation in Python";
      };
    };



    "PyYAML" = python.mkDerivation {
      name = "PyYAML-3.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"; sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };



    "arrow" = python.mkDerivation {
      name = "arrow-0.10.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/54/db/76459c4dd3561bbe682619a5c576ff30c42e37c2e01900ed30a501957150/arrow-0.10.0.tar.gz"; sha256 = "805906f09445afc1f0fc80187db8fe07670e3b25cdafa09b8d8ac264a8c0c722"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."python-dateutil"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Better dates and times for Python";
      };
    };



    "boto3" = python.mkDerivation {
      name = "boto3-1.4.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b6/7c/b9caa157b514e0a456286172862428a83814e4eda114ea1e80267de85378/boto3-1.4.7.tar.gz"; sha256 = "f79f77dca2280f7780f39d72a5088f4cf2b626c0921e7185ed6ac17abfdd7e6c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."botocore"
      self."jmespath"
      self."s3transfer"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "The AWS SDK for Python";
      };
    };



    "botocore" = python.mkDerivation {
      name = "botocore-1.7.28";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/89/ca/ed218c65ed62aa867545a3e6e8b0e0c9aeb124b6d8f99eda5347f064755b/botocore-1.7.28.tar.gz"; sha256 = "eb99d0133d5760790304d544feb07facb4df112118f29c24ce0db36c1758dc7a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."docutils"
      self."jmespath"
      self."python-dateutil"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Low-level, data-driven core of boto 3.";
      };
    };



    "certifi" = python.mkDerivation {
      name = "certifi-2017.7.27.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/20/d0/3f7a84b0c5b89e94abbd073a5f00c7176089f526edb056686751d5064cbd/certifi-2017.7.27.1.tar.gz"; sha256 = "40523d2efb60523e113b44602298f0960e900388cf3bb6043f645cf57ea9e3f5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "MPL-2.0";
        description = "Python package for providing Mozilla's CA Bundle.";
      };
    };



    "chardet" = python.mkDerivation {
      name = "chardet-3.0.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fc/bb/a5768c230f9ddb03acc9ef3f0d4a3cf93462473795d18e9535498c8f929d/chardet-3.0.4.tar.gz"; sha256 = "84ab92ed1c4d4f16916e05906b6b75a6c0fb5db821cc65e70cbd64a3e2a5eaae"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.lgpl2;
        description = "Universal encoding detector for Python 2 and 3";
      };
    };



    "click" = python.mkDerivation {
      name = "click-6.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz"; sha256 = "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "A simple wrapper around optparse for powerful command line utilities.";
      };
    };



    "clickclick" = python.mkDerivation {
      name = "clickclick-1.2.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b8/cf/2d1fb0c967616e7cd3a8e6a3aca38bc50b50137d9bc7f46cdb3e6fe03361/clickclick-1.2.2.tar.gz"; sha256 = "4a890aaa9c3990cfabd446294eb34e3dc89701101ac7b41c1bff85fc210f6d23"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."click"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Click utility functions";
      };
    };



    "dnspython" = python.mkDerivation {
      name = "dnspython-1.15.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e4/96/a598fa35f8a625bc39fed50cdbe3fd8a52ef215ef8475c17cabade6656cb/dnspython-1.15.0.zip"; sha256 = "40f563e1f7a7b80dc5a4e76ad75c23da53d62f1e15e6e517293b04e1f84ead7c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "DNS toolkit";
      };
    };



    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"; sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };



    "idna" = python.mkDerivation {
      name = "idna-2.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f4/bd/0467d62790828c23c47fc1dfa1b1f052b24efdf5290f071c7a91d0d82fd3/idna-2.6.tar.gz"; sha256 = "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Internationalized Domain Names in Applications (IDNA)";
      };
    };



    "jmespath" = python.mkDerivation {
      name = "jmespath-0.9.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e5/21/795b7549397735e911b032f255cff5fb0de58f96da794274660bca4f58ef/jmespath-0.9.3.tar.gz"; sha256 = "6a81d4c9aa62caf061cb517b4d9ad1dd300374cd4706997aff9cd6aedd61fc64"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "JSON Matching Expressions";
      };
    };



    "kmsclient" = python.mkDerivation {
      name = "kmsclient-0.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/45/ee/c88b2448cbc02e6075248653bc28ec3605e209ae6c13d53feb938055a4e7/kmsclient-0.3.tar.gz"; sha256 = "243b570b656e21720d1b85eb41eafa4f411ef96d5ecb68d4ee5b709f7962e7da"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."boto3"
      self."clickclick"
      self."pyperclip"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "For encrypting and decrypting using a specific key from amazons kms";
      };
    };



    "py" = python.mkDerivation {
      name = "py-1.4.34";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/68/35/58572278f1c097b403879c1e9369069633d1cbad5239b9057944bb764782/py-1.4.34.tar.gz"; sha256 = "0f2d585d22050e90c7d293b6451c83db097df77871974d90efd5a30dc12fcde3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "library with cross-python path, ini-parsing, io, code, log facilities";
      };
    };



    "pyperclip" = python.mkDerivation {
      name = "pyperclip-1.5.27";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/7b/a5/48eaa1f2d77f900679e9759d2c9ab44895e66e9612f7f6b5333273b68f29/pyperclip-1.5.27.zip"; sha256 = "a3cb6df5d8f1557ca8fc514d94fabf50dc5a97042c90e5ba4f3611864fed3fc5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "A cross-platform clipboard module for Python. (only handles plain text for now)";
      };
    };



    "pystache" = python.mkDerivation {
      name = "pystache-0.5.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d6/fd/eb8c212053addd941cc90baac307c00ac246ac3fce7166b86434c6eae963/pystache-0.5.4.tar.gz"; sha256 = "f7bbc265fb957b4d6c7c042b336563179444ab313fb93a719759111eabd3b85a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Mustache for Python";
      };
    };



    "pytest" = python.mkDerivation {
      name = "pytest-3.2.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/53/d0/208853c09be8377e6d4de7c0df875ef7ef37189373d76a74b65b44e50528/pytest-3.2.3.tar.gz"; sha256 = "27fa6617efc2869d3e969a3e75ec060375bfb28831ade8b5cdd68da3a741dc3c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."py"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "pytest: simple powerful testing with Python";
      };
    };



    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/54/bb/f1db86504f7a49e1d9b9301531181b00a1c7325dc85a29160ee3eaa73a54/python-dateutil-2.6.1.tar.gz"; sha256 = "891c38b2a02f5bb1be3e4793866c8df49c7d19baabf9c1bad62547e0b4866aca"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };



    "raven" = python.mkDerivation {
      name = "raven-6.2.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/c1/97/38e74c7521737c965281b43440b274955e211b1d5319c256d8525d9d2cad/raven-6.2.1.tar.gz"; sha256 = "c0a30bcc3e3206059f79656d80362ce080b1c991c95d867edce559a7294570fe"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytest"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.bsdOriginal;
        description = "Raven is a client for Sentry (https://getsentry.com)";
      };
    };



    "requests" = python.mkDerivation {
      name = "requests-2.18.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/b0/e1/eab4fc3752e3d240468a8c0b284607899d2fbfb236a56b7377a329aa8d09/requests-2.18.4.tar.gz"; sha256 = "9c443e7324ba5b85070c4a818ade28bfabedf16ea10206da1132edaa6dda237e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."chardet"
      self."idna"
      self."urllib3"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Python HTTP for Humans.";
      };
    };



    "s3transfer" = python.mkDerivation {
      name = "s3transfer-0.1.11";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a8/58/d264e95e1b19a811fc52ff41c95dafd9c70cc7457b658bc04d87dfad31de/s3transfer-0.1.11.tar.gz"; sha256 = "76f1f58f4a47e2c8afa135e2c76958806a3abbc42b721d87fd9d11409c75d979"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."botocore"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "An Amazon S3 Transfer Manager";
      };
    };



    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };



    "stups" = python.mkDerivation {
      name = "stups-1.1.15";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/af/31/83c579f185f04f534b2b51edf1454ee9c6958865896939b32601ef217566/stups-1.1.15.tar.gz"; sha256 = "be969b1d7dd0b15f1bd6870bd63bdfe8f766c674188bd907d69ccb9d114f4b0c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."click"
      self."stups-cli-support"
      self."stups-fullstop"
      self."stups-kio"
      self."stups-pierone"
      self."stups-piu"
      self."stups-senza"
      self."stups-zign"
      self."zalando-aws-cli"
      self."zalando-deploy-cli"
      self."zalando-kubectl"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "STUPS meta package";
      };
    };



    "stups-cli-support" = python.mkDerivation {
      name = "stups-cli-support-1.1.15";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/44/82/28b6e73f2d5d78ee089eb06484f935d0668af01dec9d284ab2f1579ef15f/stups-cli-support-1.1.15.tar.gz"; sha256 = "71a905f80fc63277ffda84135bd22d1f2cb4d43fc54b9aea60a5a35c492c64e5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."clickclick"
      self."dnspython"
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "STUPS CLI support library";
      };
    };



    "stups-fullstop" = python.mkDerivation {
      name = "stups-fullstop-1.1.31";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9d/c8/66755f56653efd686c099ff5cb4618bdec66907835b9b6dc56ab7b3d4fb8/stups-fullstop-1.1.31.tar.gz"; sha256 = "2208618c0aea664df7c45c0f75794a05fea860e5688e360bb29f4556b98cfa32"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."clickclick"
      self."requests"
      self."stups-cli-support"
      self."stups-zign"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Simple command line utility to view Fullstop violations";
      };
    };



    "stups-kio" = python.mkDerivation {
      name = "stups-kio-0.1.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e4/6f/9c0aa99f401d4dbc814b675a1e56f95a906aa90c551d891573c5a3649d37/stups-kio-0.1.18.tar.gz"; sha256 = "a97be61b4b9a13718d0ca397a2bc2c48d5045e840f029dae4a5556c8a24666a6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."clickclick"
      self."requests"
      self."stups-cli-support"
      self."stups-zign"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Simple command line utility to manage Kio applications and application versions";
      };
    };



    "stups-pierone" = python.mkDerivation {
      name = "stups-pierone-1.1.30";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ed/21/0fbf2ddae9eb28e82cd1c7e7b01336e080adfc4c86abdd650756f44c1c95/stups-pierone-1.1.30.tar.gz"; sha256 = "fa429764b681f1b08f9a86cd0e63b39b7cc8300cebe689a74343dc1e802d0c45"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."clickclick"
      self."requests"
      self."stups-cli-support"
      self."stups-zign"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Pier One Docker registry CLI";
      };
    };



    "stups-piu" = python.mkDerivation {
      name = "stups-piu-1.1.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/dc/ef/5cd7a5120ee8bfc205d72d1d58dd26f789e9d9608fb723cac53f629b8b35/stups-piu-1.1.12.tar.gz"; sha256 = "819eb5a14fa0f74d04ed6e25804cde90ef386bf0a6d9b691839eea0637181d11"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."boto3"
      self."botocore"
      self."clickclick"
      self."pyperclip"
      self."requests"
      self."stups-zign"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Command line client for \"even\" SSH access granting service";
      };
    };



    "stups-senza" = python.mkDerivation {
      name = "stups-senza-2.1.84";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fd/0a/fdb690b130bb209cbef9aa4b3e849062a26f4d8147edb1a7463ba5f11c80/stups-senza-2.1.84.tar.gz"; sha256 = "460db83d4dba861d53a533af244cca4cd483d7756014ed2817cdc39533e7de86"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."arrow"
      self."boto3"
      self."botocore"
      self."clickclick"
      self."dnspython"
      self."pystache"
      self."pytest"
      self."raven"
      self."stups-pierone"
      self."typing"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "AWS Cloud Formation deployment CLI";
      };
      # typing is part of python35
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
        sed -i 's/typing//g' requirements.txt
      '';
    };



    "stups-tokens" = python.mkDerivation {
      name = "stups-tokens-1.1.19";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/80/bb/d9b6991f59b7542ed6de9837e9160af066f6f47fb9515a412f0311315d2f/stups-tokens-1.1.19.tar.gz"; sha256 = "7830ad83ccbfd52a9734608ffcefcca917137ce9480cc91a4fbd321a4aca3160"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."requests"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Python library to manage OAuth access tokens";
      };
    };



    "stups-zign" = python.mkDerivation {
      name = "stups-zign-1.1.31";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/01/34/7a91f7f555d3d0df5ccaf639e29609ef4d67c8dc8d46ca15f810494bbc4e/stups-zign-1.1.31.tar.gz"; sha256 = "54f3b8db62fb34083302ee622b521fef66a212894e6a1a40aee93d948e7f39c7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."clickclick"
      self."requests"
      self."stups-cli-support"
      self."stups-tokens"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "OAuth2 token management CLI";
      };
    };



    "typing" = python.mkDerivation {
      name = "typing-3.6.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ca/38/16ba8d542e609997fdcd0214628421c971f8c395084085354b11ff4ac9c3/typing-3.6.2.tar.gz"; sha256 = "d514bd84b284dd3e844f0305ac07511f097e325171f6cc4a20878d11ad771849"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.psfl;
        description = "Type Hints for Python";
      };
    };



    "urllib3" = python.mkDerivation {
      name = "urllib3-1.22";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ee/11/7c59620aceedcc1ef65e156cc5ce5a24ef87be4107c2b74458464e437a5d/urllib3-1.22.tar.gz"; sha256 = "cc44da8e1145637334317feebd728bd869a35285b93cbb4cca2577da7e62db4f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."certifi"
      self."idna"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "HTTP library with thread-safe connection pooling, file post, and more.";
      };
    };



    "zalando-aws-cli" = python.mkDerivation {
      name = "zalando-aws-cli-1.1.6";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/82/cd/1e6c37c1dea268c3458f1912a1a4b3046e1ccafe5ca2376f219f945d0270/zalando-aws-cli-1.1.6.tar.gz"; sha256 = "f925ec28cf36751a0842ab86925c0bc9cf2a48191d059e4acec340d404a90063"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyJWT"
      self."PyYAML"
      self."clickclick"
      self."stups-zign"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "AWS login CLI";
      };
    };



    "zalando-deploy-cli" = python.mkDerivation {
      name = "zalando-deploy-cli-0.33.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ea/cd/8d7effc66861c670aedd268dd0dadd737aef77fc91d88ba27a2532f5dc51/zalando-deploy-cli-0.33.1.tar.gz"; sha256 = "e601b6647aef9ab99777e905f7fca817f204186ff34198401fec1296a2d3de52"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."boto3"
      self."clickclick"
      self."pystache"
      self."requests"
      self."stups-pierone"
      self."stups-zign"
      self."zalando-kubectl"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "UNKNOWN";
      };
    };



    "zalando-kubectl" = python.mkDerivation {
      name = "zalando-kubectl-1.7.6.post7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/56/d0/ad1d753e42957ca46e70648b3d9d168bbab5141285a6562ae641a4875591/zalando-kubectl-1.7.6.post7.tar.gz"; sha256 = "8ad8190b51ef87fdfe4ee88602e8ccf16f9b20b60453053357ae835241b1b5d1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."clickclick"
      self."requests"
      self."stups-cli-support"
      self."stups-zign"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Kubectl wrapper in Python with OAuth token auth";
      };
    };

  };
  overrides = import ./requirements_override.nix { inherit pkgs python; };
  commonOverrides = [

  ];

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            ([overrides] ++ commonOverrides)
         )
   )
