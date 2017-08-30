with import <nixpkgs> {};
with pkgs.python35Packages;

with pkgs.lib;

let
  isPy3K = strings.substring 0 1 python.majorVersion == "3";

  dependencies = rec {

    _dns = with python35Packages; buildPythonPackage rec {
      name = "dnspython-1.15.0";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/d/dnspython/${name}.zip";
        sha256 = "40f563e1f7a7b80dc5a4e76ad75c23da53d62f1e15e6e517293b04e1f84ead7c";
      };
      doCheck = false;
    };

    _clickclick = with python35Packages; buildPythonPackage rec {
      name = "clickclick-1.2.1";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/c/clickclick/${name}.tar.gz";
        sha256 = "22eedfce2499d7a8c5b8c868fc93a495eb74bf7b753a6cb9ed2aa6a32a3ddd05";
      };
      propagatedBuildInputs = [ click pyyaml ];
      doCheck = false;
    };

    _keyringsalt = with python35Packages; buildPythonPackage rec {
      name = "keyrings.alt-1.1.1";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/k/keyrings.alt/${name}.tar.gz";
        sha256 = "2f1a55849504644795076291bcc66a7266e0388dea13fe23a89d25c99e355d22";
      };
      buildInputs = [ mock ];
      propagatedBuildInputs = [ libffi openssl _cryptography ];
      doCheck = false;
    };

    _cryptography = with python35Packages; buildPythonPackage rec {
      name = "cryptography-1.7.1";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/c/cryptography/${name}.tar.gz";
        sha256 = "953fef7d40a49a795f4d955c5ce4338abcec5dea822ed0414ed30348303fdb4c";
      };
      buildInputs = [ pkgs.openssl pretend _cryptography-vectors iso8601 pyasn1 pytest_29
                      hypothesis pytz];
      __impureHostDeps = [ "/usr/lib" ];
      propagatedBuildInputs = [ six idna ipaddress pyasn1 cffi pyasn1-modules pytz ];
    };

    _cryptography-vectors = with python35Packages; buildPythonPackage rec {
      name = "cryptography_vectors-1.7.1";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/c/cryptography-vectors/${name}.tar.gz";
        sha256 = "47e91b70bbf6852cb96a478cb715ca9234e5ff049c1956088c45c9f738f955f4";
      };
    };

    _stups-tokens = with python35Packages; buildPythonPackage rec {
      name = "stups-tokens-1.1.19";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-tokens/${name}.tar.gz";
        sha256 = "7830ad83ccbfd52a9734608ffcefcca917137ce9480cc91a4fbd321a4aca3160";
      };
      propagatedBuildInputs = [ requests2 ];
      doCheck = false;
    };

    _stups-cli-support = with python35Packages; buildPythonPackage rec {
       name = "stups-cli-support-1.1.15";
       src = fetchurl {
         url    = "https://pypi.io/packages/source/s/stups-cli-support/${name}.tar.gz";
         sha256 = "71a905f80fc63277ffda84135bd22d1f2cb4d43fc54b9aea60a5a35c492c64e5";
       };
       propagatedBuildInputs = [ pyyaml _dns requests2 _clickclick ];
       doCheck = false;
    };

    _oauth2client = buildPythonPackage rec {
      name = "oauth2client-4.0.0";

      src = pkgs.fetchurl {
        url    = "mirror://pypi/o/oauth2client/${name}.tar.gz";
        sha256 = "80be5420889694634b8517b4acd3292ace881d9d1aa9d590d37ec52faec238c7";
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
      name = "stups-zign-1.1.30";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-zign/${name}.tar.gz";
        sha256 = "a05ce6f10b07265f2121354e4287a4c3716cfe6233093a5a1607d8745642cfd2";
      };

      propagatedBuildInputs = [ _oauth2client pyyaml requests2 keyring _keyringsalt _clickclick _stups-tokens _stups-cli-support];
      doCheck = false;
    };

    _stups-pierone = with python35Packages; buildPythonApplication rec {
      name = "stups-pierone-1.1.27";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-pierone/${name}.tar.gz";
        sha256 = "fee665921ae1eb0821739221355ac80a42dd3f1b8dd65e6d30b6e928e87941e9";
      };
      propagatedBuildInputs = [ pyyaml requests2 _stups-zign ];
      doCheck = false;
    };

    _aws-saml-login = with python35Packages; buildPythonApplication rec {
      name = "aws-saml-login-1.0.11";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/a/aws-saml-login/${name}.tar.gz";
        sha256 = "2cb5b50d3ac696a94dcc934abc5c3d81f7d9da44915250eea6aa57424dac9111";
      };
      propagatedBuildInputs = [ beautifulsoup4 boto3 docutils ];
      doCheck = false;
    };

    _stups-mai = with python35Packages; buildPythonApplication rec {
      name = "stups-mai-1.0.10";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-mai/${name}.tar.gz";
        sha256 = "147f45544ce1f3e1c2003490b0143e52ce35f90ac1f692941a4c7c91013a2d8a";
      };
      propagatedBuildInputs = [ _clickclick _keyringsalt _aws-saml-login keyring _cryptography ];
      doCheck = false;
    };

    _pystache = with python35Packages; buildPythonPackage rec {
      name = "pystache-0.5.4";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/p/pystache/${name}.tar.gz";
        sha256 = "f7bbc265fb957b4d6c7c042b336563179444ab313fb93a719759111eabd3b85a";
      };
      doCheck = false;
    };

    _stups-senza = with python35Packages; buildPythonApplication rec {
      name = "stups-senza-2.1.77";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-senza/${name}.tar.gz";
        sha256 = "d28739692735d5116a65fc48a37252447c542f835ea206ec52b2e00e9251c417";
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
      name = "stups-piu-1.1.12";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-piu/${name}.tar.gz";
        sha256 = "819eb5a14fa0f74d04ed6e25804cde90ef386bf0a6d9b691839eea0637181d11";
      };
      propagatedBuildInputs = [ pyyaml botocore boto3 docutils _stups-zign pyperclip ];
      doCheck = false;
    };

    _stups-kio = with python35Packages; buildPythonApplication rec {
      name = "stups-kio-0.1.18";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-kio/${name}.tar.gz";
        sha256 = "a97be61b4b9a13718d0ca397a2bc2c48d5045e840f029dae4a5556c8a24666a6";
      };
      propagatedBuildInputs = [ requests2 _clickclick _stups-cli-support _stups-zign ];
      doCheck = false;
    };

    _stups-fullstop = with python35Packages; buildPythonApplication rec {
      name = "stups-fullstop-1.1.28";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-fullstop/${name}.tar.gz";
        sha256 = "b58c571b3826bdc66c84875a89fb1e043ede52af41d9bbcb206a74b3cc4fca33";
      };
      propagatedBuildInputs = [ _clickclick _stups-cli-support _stups-zign ];
      doCheck = false;
    };

    _stups-berry = with python35Packages; buildPythonApplication rec {
      name = "stups-berry-1.0.27";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/stups-berry/${name}.tar.gz";
        sha256 = "32ff222bfc9b234725b01b6122976303dfca1bb47aefc177c41773e9d501bc06";
      };
      propagatedBuildInputs = [ pyyaml boto3 _dns docutils ];
      doCheck = false;
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
      '';
    };

    _scmsource = with python35Packages; buildPythonApplication rec {
      name = "scm-source-1.0.10";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/s/scm-source/${name}.tar.gz";
        sha256 = "df7375bb1b62aeb8461d2046f42e61a14b0209fff72b35fb5b7dcf45e30267d0";
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

      doCheck = false;

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
      name = "zalando-aws-cli-1.1.6";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/z/zalando-aws-cli/${name}.tar.gz";
        sha256 = "f925ec28cf36751a0842ab86925c0bc9cf2a48191d059e4acec340d404a90063";
      };
      propagatedBuildInputs = [ pyyaml _clickclick _pyjwt _stups-zign ];
      doCheck = false;
    };

    _kubectl = with python35Packages; buildPythonApplication rec {
      name = "zalando-kubectl-1.6.0";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/z/zalando-kubectl/${name}.tar.gz";
        sha256 = "ff195847c7377a63c53b91ff086ae81c028ae94abc1ba21072335c7252261ea3";
      };
      propagatedBuildInputs = [ pyyaml _clickclick _stups-zign _stups-cli-support requests2 ];
      doCheck = false;
    };

    _deploycli = with python35Packages; buildPythonApplication rec {
      name = "zalando-deploy-cli-0.28";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/z/zalando-deploy-cli/${name}.tar.gz";
        sha256 = "f4a57e9ed6c69835430cab45e9d6e868e0d89a5005c546286866624753e5a00f";
      };
      propagatedBuildInputs = [ _clickclick _stups-zign _stups-pierone _pystache _kubectl requests2 ];
      doCheck = false;
    };

    _easydict = buildPythonPackage rec {
      name = "${pname}-${version}";
      pname = "easydict";
      version = "1.7";
    
      src = fetchPypi {
        inherit pname version;
        sha256 = "1xpnwjdw4x5kficjgcajqcal6bxcb0ax8l6hdkww9fp6lrh28x8v";
      };
    
      docheck = false; # No tests in archive
    
      meta = {
        homepage = https://github.com/makinacorpus/easydict;
        license = with stdenv.lib; licenses.lgpl3;
        description = "Access dict values as attributes (works recursively)";
      };
    };

    _zmonCli = with python35Packages; buildPythonApplication rec {
      name = "zmon-cli-1.1.50";
      src = fetchurl {
        url    = "https://pypi.io/packages/source/z/zmon-cli/${name}.tar.gz";
        sha256 = "9ae39183acc1ba2c5940772370b92596fdd9db8a91da9ec35be1e28607a4720b";
      };
      propagatedBuildInputs = [ _clickclick _stups-zign requests2 pyyaml _easydict ];
      doCheck = false;
    };
  };

in with dependencies; buildPythonApplication rec {
  name = "stups-${version}";
  version = "1.1.15";

  disabled = !isPy3K;

  src = fetchurl {
    url    = "https://pypi.io/packages/source/s/stups/${name}.tar.gz";
    sha256 = "be969b1d7dd0b15f1bd6870bd63bdfe8f766c674188bd907d69ccb9d114f4b0c";
  };

  doCheck = false;

  propagatedBuildInputs = [ _stups-zign _stups-pierone _stups-mai _stups-senza _stups-piu _stups-kio _stups-fullstop _stups-berry _scmsource _zaws _kubectl _deploycli _zmonCli];
  propagatedUserEnvPkgs = propagatedBuildInputs;

  meta = {
    homepage = "https://github.com/zalando-stups/stups-cli";
  };
}
