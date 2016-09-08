with import <nixpkgs> {};
with pkgs.python35Packages;

with pkgs.lib;

let
  isPy3K = strings.substring 0 1 python.majorVersion == "3";

  dependencies = rec {

    _clickclick = with python35Packages; buildPythonPackage rec {
      name = "clickclick-1.1";
      src = fetchurl {
        url = "https://pypi.io/packages/source/c/clickclick/${name}.tar.gz";
        md5 = "0c4ab79ba38ab4306edd744c4a025dd4";
      };
      propagatedBuildInputs = [ click pyyaml ];
      doCheck = false;
    };

    _keyringsalt = with python35Packages; buildPythonPackage rec {
      name = "keyrings.alt-1.1.1";
      src = fetchurl {
        url = "https://pypi.io/packages/source/k/keyrings.alt/${name}.tar.gz";
        md5 = "8571b04032dce5e2e9ed331a82216c15";
      };
      buildInputs = [ mock ];
      propagatedBuildInputs = [ libffi openssl cryptography ];
      doCheck = false;
    };

    _stups-tokens = with python35Packages; buildPythonPackage rec {
      name = "stups-tokens-1.0.18";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-tokens/${name}.tar.gz";
        md5 = "f046fed5865601c05be9514c3a1d5f88";
      };
      propagatedBuildInputs = [ requests2 ];
      doCheck = false;
    };

    _stups-cli-support = with python35Packages; buildPythonPackage rec {
       name = "stups-cli-support-1.0.9";
       src = fetchurl {
         url = "https://pypi.io/packages/source/s/stups-cli-support/${name}.tar.gz";
         md5 = "8d8cc3030dd4b85184dcdbb4fc5ebc99";
       };
       propagatedBuildInputs = [ pyyaml dns requests2 _clickclick ];
       doCheck = false;
    };

    _stups-zign = with python35Packages; buildPythonApplication rec {
      name = "stups-zign-1.0.23";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-zign/${name}.tar.gz";
        md5 = "c067b2360b06c4ab998ddcb41485e749";
      };

      propagatedBuildInputs = [ pyyaml requests2 keyring _keyringsalt _clickclick _stups-tokens _stups-cli-support];
      doCheck = false;
    };

    _stups-pierone = with python35Packages; buildPythonApplication rec {
      name = "stups-pierone-1.0.36";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-pierone/${name}.tar.gz";
        md5 = "100157b8dc7cc2c8c2bbe1f25f281072";
      };
      propagatedBuildInputs = [ pyyaml requests2 _stups-zign ];
      doCheck = false;
    };

    _aws-saml-login = with python35Packages; buildPythonApplication rec {
      name = "aws-saml-login-1.0.7";
      src = fetchurl {
        url = "https://pypi.io/packages/source/a/aws-saml-login/${name}.tar.gz";
        md5 = "ae0c82bc32e3ae95ae2ffa75f45fe5f0";
      };
      propagatedBuildInputs = [ beautifulsoup4 boto3 docutils ];
      doCheck = false;
    };

    _stups-mai = with python35Packages; buildPythonApplication rec {
      name = "stups-mai-1.0.8";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-mai/${name}.tar.gz";
        md5 = "70b3f35a5a69b2ffe56475ef78cf9597";
      };
      propagatedBuildInputs = [ _clickclick _keyringsalt _aws-saml-login keyring ];
      doCheck = false;
    };

    _pystache = with python35Packages; buildPythonPackage rec {
      name = "pystache-0.5.4";
      src = fetchurl {
        url = "https://pypi.io/packages/source/p/pystache/${name}.tar.gz";
        md5 = "485885e67a0f6411d5252e69b20a35ca";
      };
      doCheck = false;
    };

    _stups-senza = with python35Packages; buildPythonApplication rec {
      name = "stups-senza-2.0.123";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-senza/${name}.tar.gz";
        md5 = "df6d310b5f3f34defa9f1f1924adfb7f";
      };
      propagatedBuildInputs = [ _pystache pyyaml _stups-pierone pytest botocore boto3 docutils ];
      doCheck = false;

      # typing is part of python35
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
        sed -i 's/typing//g' requirements.txt
      '';
    };

    _stups-piu = with python35Packages; buildPythonApplication rec {
      name = "stups-piu-1.0.11";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-piu/${name}.tar.gz";
        md5 = "cf1362834b1276efbae2f2f1620ec08a";
      };
      propagatedBuildInputs = [ pyyaml _stups-zign pyperclip ];
      doCheck = false;
    };

    _stups-kio = with python35Packages; buildPythonApplication rec {
      name = "stups-kio-0.1.13";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-kio/${name}.tar.gz";
        md5 = "002b55e872c458f1552ecd090ca35b27";
      };
      propagatedBuildInputs = [ requests2 _clickclick _stups-cli-support _stups-zign ];
      doCheck = false;
    };

    _stups-fullstop = with python35Packages; buildPythonApplication rec {
      name = "stups-fullstop-1.0.28";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-fullstop/${name}.tar.gz";
        md5 = "5993d2c2bedfb63eea5c7813433229d2";
      };
      propagatedBuildInputs = [ _clickclick _stups-cli-support _stups-zign ];
      doCheck = false;
    };

    _stups-berry = with python35Packages; buildPythonApplication rec {
      name = "stups-berry-1.0.24";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-berry/${name}.tar.gz";
        md5 = "ac5d3ed687ef7622581a24c723b63870";
      };
      propagatedBuildInputs = [ pyyaml boto3 dns docutils ];
      doCheck = false;
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
      '';
    };
  };

in with dependencies; buildPythonApplication rec {
  name = "stups-${version}";
  version = "1.0.8";

  disabled = !isPy3K;

  src = fetchurl {
    url = "https://pypi.io/packages/source/s/stups/${name}.tar.gz";
    md5 = "2e562b0de104a9708318b9d9573d8954";
  };

  propagatedBuildInputs = [ _stups-zign _stups-pierone _stups-mai _stups-senza _stups-piu _stups-kio _stups-fullstop _stups-berry ];
  propagatedUserEnvPkgs = [ _stups-zign _stups-pierone _stups-mai _stups-senza _stups-piu _stups-kio _stups-fullstop _stups-berry];

  meta = {
    homepage = "https://github.com/zalando-stups/stups-cli";
  };
}
