## Senza patch

add following to build description of `stups-senza`

```nix
      # typing is part of python35
      patchPhase = ''
        sed -i 's/[\d128-\d255]//g' README.rst
        sed -i 's/typing//g' requirements.txt
      '';
```
