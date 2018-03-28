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
      name = "PyJWT-1.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ee/af/7f500e3e587c927c88422099ce7ed9247f89f3217cabf00d3f48fe3ad5fe/PyJWT-1.6.1.tar.gz"; sha256 = "dacba5786fe3bf1a0ae8673874e29f9ac497860955c501289c63b15d3daae63a"; };
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
      name = "arrow-0.12.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/e0/86/4eb5228a43042e9a80fe8c84093a8a36f5db34a3767ebd5e1e7729864e7b/arrow-0.12.1.tar.gz"; sha256 = "a558d3b7b6ce7ffc74206a86c147052de23d3d4ef0e17c210dd478c53575c4cd"; };
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



    "attrs" = python.mkDerivation {
      name = "attrs-17.4.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/8b/0b/a06cfcb69d0cb004fde8bc6f0fd192d96d565d1b8aa2829f0f20adb796e5/attrs-17.4.0.tar.gz"; sha256 = "1c7960ccfd6a005cd9f7ba884e6316b5e430a3f1a6c37c5f87d8b43f83b54ec9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "Classes Without Boilerplate";
      };
    };



    "boto3" = python.mkDerivation {
      name = "boto3-1.6.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/69/90/7d9871bbb8624ac8d92206260b4ba2923717fc0729cdc662f622f0b95edf/boto3-1.6.18.tar.gz"; sha256 = "0a8f271a21be3ac91ff50de6f3146131d8ab2a37d0209dfca3e7caadf8315abb"; };
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
      name = "botocore-1.9.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/1e/d1/013afe26b08d4984a9066399c23a772c44590306b8fc1f17547c7cf025b9/botocore-1.9.18.tar.gz"; sha256 = "254803eaca91bf28fa277641039bc06d335faa638862b54454170600a9ed0b5c"; };
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
      name = "certifi-2018.1.18";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/15/d4/2f888fc463d516ff7bf2379a4e9a552fef7f22a94147655d9b1097108248/certifi-2018.1.18.tar.gz"; sha256 = "edbc3f203427eef571f79a7692bb160a2b0f7ccaa31953e99bd17e307cf63f7d"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mpl20;
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



    "easydict" = python.mkDerivation {
      name = "easydict-1.7";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/df/e0/021f827dd5c11ac32c89f4b6bd0e3eddfd62d544112c298bf0b13e6b0def/easydict-1.7.tar.gz"; sha256 = "1b752460a6e6bac4f96cd050d41558ac2f4315c352b1275974b374c29be4f6f6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = "LPGL, see LICENSE file.";
        description = "Access dict values as attributes (works recursively).";
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



    "more-itertools" = python.mkDerivation {
      name = "more-itertools-4.1.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/db/0b/f5660bf6299ec5b9f17bd36096fa8148a1c843fa77ddfddf9bebac9301f7/more-itertools-4.1.0.tar.gz"; sha256 = "c9ce7eccdcb901a2c75d326ea134e0886abfbea5f93e91cc95de9507c0816c44"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "More routines for operating on iterables, beyond itertools";
      };
    };



    "pluggy" = python.mkDerivation {
      name = "pluggy-0.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/11/bf/cbeb8cdfaffa9f2ea154a30ae31a9d04a1209312e2919138b4171a1f8199/pluggy-0.6.0.tar.gz"; sha256 = "7f8ae7f5bdf75671a718d2daf0a64b7885f74510bcd98b1a0bb420eb9a9d0cff"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "plugin and hook calling mechanisms for python";
      };
    };



    "py" = python.mkDerivation {
      name = "py-1.5.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f7/84/b4c6e84672c4ceb94f727f3da8344037b62cee960d80e999b1cd9b832d83/py-1.5.3.tar.gz"; sha256 = "29c9fab495d7528e80ba1e343b958684f4ace687327e6f789a94bf3d1915f881"; };
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
      name = "pyperclip-1.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/5b/06/86e3c6a55cacef0e4ec7c25379ff7fcd1a88fd939ecefd442b535c792fa4/pyperclip-1.6.0.tar.gz"; sha256 = "ce829433a9af640e08ee89b20f7c62132714bcc5d77df114044d0fccb8c3b3b8"; };
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
      name = "pytest-3.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2d/56/6019153cdd743300c5688ab3b07702355283e53c83fbf922242c053ffb7b/pytest-3.5.0.tar.gz"; sha256 = "fae491d1874f199537fd5872b5e1f0e74a009b979df9d53d1553fd03da1703e1"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."attrs"
      self."more-itertools"
      self."pluggy"
      self."py"
      self."six"
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
      name = "raven-6.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/03/8a/f28e01894cbd34c9c33dce88fc9e1a39c8930f9d1ed8e35a8d5499083af8/raven-6.6.0.tar.gz"; sha256 = "92bf4c4819472ed20f1b9905eeeafe1bc6fe5f273d7c14506fdb8fb3a6ab2074"; };
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
      name = "s3transfer-0.1.13";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/9a/66/c6a5ae4dbbaf253bd662921b805e4972451a6d214d0dc9fb3300cb642320/s3transfer-0.1.13.tar.gz"; sha256 = "90dc18e028989c609146e241ea153250be451e05ecc0c2832565231dacdf59c1"; };
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



    "scm-source" = python.mkDerivation {
      name = "scm-source-1.0.11";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/15/4f/880d17084cd774d93a3ba7f6dfa4837a8b838bfee699fe8db0de2ed6e38a/scm-source-1.0.11.tar.gz"; sha256 = "95777e83084f32665640746e02884a21892c6cb445c969cb9befe74919bd2c36"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."clickclick"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "CLI to generate scm-source.json";
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



    "stups-berry" = python.mkDerivation {
      name = "stups-berry-1.0.28";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/01/81/2a3e118bd389f72e39dfd7402c2e594962b389746803f986786a51a2e21e/stups-berry-1.0.28.tar.gz"; sha256 = "5274817853e1584dc102f8ed0fec6e165c2b90f12b4a75af72fdf317292f61e2"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."boto3"
      self."dnspython"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Credentials distribution agent";
      };

      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
      '';
    };



    "stups-cli-support" = python.mkDerivation {
      name = "stups-cli-support-1.1.20";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/91/66/512fef98c9a3374e163d37a2120d862c9cffc629949db72dc7fa6ac858e1/stups-cli-support-1.1.20.tar.gz"; sha256 = "3ca35c5a63eec4eda077114ea8abeda1f019d25d39bd8ab7e089bd2487da85d9"; };
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
      name = "stups-kio-0.1.20";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/14/be/7cddab47c31f47c5b5724c14fda79cfccde11b865322f60cb453519644db/stups-kio-0.1.20.tar.gz"; sha256 = "b5de8538eca0297696654da5d1c217edf9328c95ac69cdbff9a8ea23d3e8d0eb"; };
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
        description = "Simple command line utility to manage Kio applications";
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
      name = "stups-piu-1.1.16";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/20/a8/45136321c7d8aa7edaa08b6922cb5d22ea6140a9a80b5dbd21fcbfca91bd/stups-piu-1.1.16.tar.gz"; sha256 = "e2fa2e8e23a6ea5ba7e461d747ae7322f10d72f72a9c52cbdd53e1ff5965bb53"; };
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
      name = "stups-senza-2.1.96";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/71/23c8ceba03bb241463ea680d31addecf92b912962a67c2429ee585a248da/stups-senza-2.1.96.tar.gz"; sha256 = "7cf0b430ff5808d692f4c5563ed94d8a6e21f2098c0e993d6c1cae5bcb9ee4fc"; };
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

      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
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
      name = "typing-3.6.4";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ec/cc/28444132a25c113149cec54618abc909596f0b272a74c55bab9593f8876c/typing-3.6.4.tar.gz"; sha256 = "d400a9344254803a2368533e4533a4200d21eb7b6b729c173bc38201a74db3f2"; };
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
      name = "zalando-aws-cli-1.2.4.22";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/13/32/c2768cf48e2a5561d82d3fda5c6a829800961262d70473d3690b4a84f429/zalando-aws-cli-1.2.4.22.tar.gz"; sha256 = "046ca3b6325e1565b2dac01ba6ca178a8c07b0e86082dd0f926fd8459708e487"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyJWT"
      self."PyYAML"
      self."boto3"
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
      name = "zalando-deploy-cli-1.0.10";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/fe/a0/08dc3a4ca04f4db3a063049905757c918d9d7408eba7df7696652500fe5c/zalando-deploy-cli-1.0.10.tar.gz"; sha256 = "3111c74eb0b8600b7753c53075b45d3d94bec838d9d3906c7b35ea7e54a21548"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."boto3"
      self."clickclick"
      self."pystache"
      self."requests"
      self."stups-pierone"
      self."stups-zign"
      self."zalando-aws-cli"
      self."zalando-kubectl"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.mit;
        description = "UNKNOWN";
      };
    };



    "zalando-kubectl" = python.mkDerivation {
      name = "zalando-kubectl-1.9.3.30";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/d4/d2/a2bb392e4f658d8aa1da680c2cf7df9b400ca634d3a7f13cf2661248d405/zalando-kubectl-1.9.3.30.tar.gz"; sha256 = "b9f8246c27ac5867d1ba51ea7942134d42303b9b6d96656e152890f9d0c0a74b"; };
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



    "zmon-cli" = python.mkDerivation {
      name = "zmon-cli-1.1.56";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ce/92/303efb8a2eb1cce5091daab713a9ccc54a9d03fe2ca91ab750b303d0ab80/zmon-cli-1.1.56.tar.gz"; sha256 = "1c74e729cd48a98aa27df2c074730633a614f03da08f9a1916ad7bf107ccbfbb"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."clickclick"
      self."easydict"
      self."requests"
      self."stups-zign"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.asl20;
        description = "Command line interface for Zalando's monitoring tool ZMON";
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
