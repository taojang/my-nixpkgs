with import <nixpkgs> {};
with pkgs.python35Packages;

with pkgs.lib;

let
  isPy3K = strings.substring 0 1 python.majorVersion == "3";

  dependencies = rec {

    _dns = with python35Packages; buildPythonPackage rec {
      name = "dnspython-1.15.0";
      src = fetchurl {
        url = "https://pypi.io/packages/source/d/dnspython/${name}.zip";
        md5 = "05d33ffb5d8f35ae0474bb952778a344";
      };
      doCheck = false;
    };

    _clickclick = with python35Packages; buildPythonPackage rec {
      name = "clickclick-1.2.1";
      src = fetchurl {
        url = "https://pypi.io/packages/source/c/clickclick/${name}.tar.gz";
        md5 = "bd7e136f0ed3516589795be5c60dc386";
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
      propagatedBuildInputs = [ libffi openssl _cryptography ];
      doCheck = false;
    };

    _cryptography = with python35Packages; buildPythonPackage rec {
      name = "cryptography-1.7.1";
      src = fetchurl {
        url = "https://pypi.io/packages/source/c/cryptography/${name}.tar.gz";
        md5 = "2f63dee6ace602d1d20d1995f8538015";
      };
      buildInputs = [ pkgs.openssl pretend _cryptography-vectors iso8601 pyasn1 pytest_29
                      hypothesis pytz];
      __impureHostDeps = [ "/usr/lib" ];
      propagatedBuildInputs = [ six idna ipaddress pyasn1 cffi pyasn1-modules pytz ];
    };

    _cryptography-vectors = with python35Packages; buildPythonPackage rec {
      name = "cryptography_vectors-1.7.1";
      src = fetchurl {
        url = "https://pypi.io/packages/source/c/cryptography-vectors/${name}.tar.gz";
        md5 = "4e6b8bfa8285a67f2aa1e0af5d2834d6";
      };
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
       name = "stups-cli-support-1.1.15";
       src = fetchurl {
         url = "https://pypi.io/packages/source/s/stups-cli-support/${name}.tar.gz";
         md5 = "473a3bbdc453404d81251121a31daff8";
       };
       propagatedBuildInputs = [ pyyaml _dns requests2 _clickclick ];
       doCheck = false;
    };

    _oauth2client = buildPythonPackage rec {
      name = "oauth2client-4.0.0";

      src = pkgs.fetchurl {
        url = "mirror://pypi/o/oauth2client/${name}.tar.gz";
        md5 = "7969836a49e6743ecd746997b2025926";
      };

      propagatedBuildInputs = [ six httplib2 pyasn1-modules rsa ];
      doCheck = false;

      meta = {
        description = "A client library for OAuth 2.0";
        homepage = http://github.com/google/oauth2client/;
        license = licenses.bsd2;
      };
    };

    _stups-zign = with python35Packages; buildPythonApplication rec {
      name = "stups-zign-1.1.28";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-zign/${name}.tar.gz";
        md5 = "a535cf97a9e8e7d8ed92f3138c57a02d";
      };

      propagatedBuildInputs = [ _oauth2client pyyaml requests2 keyring _keyringsalt _clickclick _stups-tokens _stups-cli-support];
      doCheck = false;
    };

    _stups-pierone = with python35Packages; buildPythonApplication rec {
      name = "stups-pierone-1.0.38";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-pierone/${name}.tar.gz";
        md5 = "f5c18149e07dd854248102fab57c24d2";
      };
      propagatedBuildInputs = [ pyyaml requests2 _stups-zign ];
      doCheck = false;
    };

    _aws-saml-login = with python35Packages; buildPythonApplication rec {
      name = "aws-saml-login-1.0.11";
      src = fetchurl {
        url = "https://pypi.io/packages/source/a/aws-saml-login/${name}.tar.gz";
        md5 = "7ae887b616105346035848fe4dc0f57b";
      };
      propagatedBuildInputs = [ beautifulsoup4 boto3 docutils ];
      doCheck = false;
    };

    _stups-mai = with python35Packages; buildPythonApplication rec {
      name = "stups-mai-1.0.10";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-mai/${name}.tar.gz";
        md5 = "f55b8d5fbbd84505886bda1b81002fb2";
      };
      propagatedBuildInputs = [ _clickclick _keyringsalt _aws-saml-login keyring _cryptography ];
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
      name = "stups-senza-2.1.66";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-senza/${name}.tar.gz";
        md5 = "f2e660fe94b563baed7eb91dac0086ab";
      };
      propagatedBuildInputs = [ _dns _pystache pyyaml _stups-pierone pytest arrow botocore boto3 docutils raven ];
      doCheck = false;

      # typing is part of python35
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
        sed -i 's/typing//g' requirements.txt
      '';
    };

    _stups-piu = with python35Packages; buildPythonApplication rec {
      name = "stups-piu-1.0.15";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-piu/${name}.tar.gz";
        md5 = "2482295bce977e2c20a1179888b6a974";
      };
      propagatedBuildInputs = [ pyyaml botocore boto3 docutils _stups-zign pyperclip ];
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
      name = "stups-fullstop-1.0.29";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-fullstop/${name}.tar.gz";
        md5 = "32c3da93d1b665e558561396eb412530";
      };
      propagatedBuildInputs = [ _clickclick _stups-cli-support _stups-zign ];
      doCheck = false;
    };

    _stups-berry = with python35Packages; buildPythonApplication rec {
      name = "stups-berry-1.0.25";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/stups-berry/${name}.tar.gz";
        md5 = "15113351a8fe13a58b7e985e36c0ce5c";
      };
      propagatedBuildInputs = [ pyyaml boto3 _dns docutils ];
      doCheck = false;
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
      '';
    };

    _scmsource = with python35Packages; buildPythonApplication rec {
      name = "scm-source-1.0.9";
      src = fetchurl {
        url = "https://pypi.io/packages/source/s/scm-source/${name}.tar.gz";
        md5 = "18db62d03076bd574602713535e46fb1";
      };
      propagatedBuildInputs = [ pyyaml _clickclick ];
      doCheck = false;
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
      '';
    };


    _pyjwt = buildPythonPackage rec {
      version = "1.4.2";
      name = "pyjwt-${version}";
  
      src = pkgs.fetchurl {
        url = "http://github.com/progrium/pyjwt/archive/${version}.tar.gz";
        sha256 = "06vg84aicwkv0kli8i4jhg0kc6298cmh38ib058q01yxzk6q17gn";
      };
  
      propagatedBuildInputs = [ pycrypto ecdsa ];
  
      meta = {
        description = "JSON Web Token implementation in Python";
        longDescription = "A Python implementation of JSON Web Token draft 01";
        homepage = https://github.com/progrium/pyjwt;
        downloadPage = https://github.com/progrium/pyjwt/releases;
        license = licenses.mit;
        maintainers = with maintainers; [ prikhi ];
        platforms = platforms.unix;
      };
    };

    _zaws = with python35Packages; buildPythonApplication rec {
      name = "zalando-aws-cli-1.1.4";
      src = fetchurl {
        url = "https://pypi.io/packages/source/z/zalando-aws-cli/${name}.tar.gz";
        md5 = "8139277eb05ce0034111199716943f78";
      };
      propagatedBuildInputs = [ pyyaml _clickclick _pyjwt _stups-zign ];
      doCheck = false;
    };

    _kubectl = with python35Packages; buildPythonApplication rec {
      name = "zalando-kubectl-0.23";
      src = fetchurl {
        url = "https://pypi.io/packages/source/z/zalando-kubectl/${name}.tar.gz";
        md5 = "33440a62a7870170fc26d93c12461a7a";
      };
      propagatedBuildInputs = [ pyyaml _clickclick _stups-zign _stups-cli-support requests2 ];
      doCheck = false;
    };

    _deploycli = with python35Packages; buildPythonApplication rec {
      name = "zalando-deploy-cli-0.21";
      src = fetchurl {
        url = "https://pypi.io/packages/source/z/zalando-deploy-cli/${name}.tar.gz";
        md5 = "5e04dfa36b0fbed27e974d9f4a26714f";
      };
      propagatedBuildInputs = [ _clickclick _stups-zign _stups-pierone _pystache _kubectl requests2 ];
      doCheck = false;
    };
  };

in with dependencies; buildPythonApplication rec {
  name = "stups-${version}";
  version = "1.1.14";

  disabled = !isPy3K;

  src = fetchurl {
    url = "https://pypi.io/packages/source/s/stups/${name}.tar.gz";
    md5 = "fd38949a52d1272609ef7af2a52c3cf0";
  };

  doCheck = false;

  propagatedBuildInputs = [ _stups-zign _stups-pierone _stups-mai _stups-senza _stups-piu _stups-kio _stups-fullstop _stups-berry _scmsource _zaws _kubectl _deploycli ];
  propagatedUserEnvPkgs = propagatedBuildInputs;

  meta = {
    homepage = "https://github.com/zalando-stups/stups-cli";
  };
}
