# Release directory

To publish a new `sealos-manager` release just run the make release
script from this directory.

## Stable release

```bash
release="version" stable="true" ./make-sealos-manager-release.bash
```

## Beta release

```bash
release="version" ./make-sealos-manager-release.bash
```


## Release Files

* Files `stable.json` and `beta.json` contain feed release to be consumed
later from other tools.


* Files `latest-beta` and `latest-stable` contain last release version
to be check by our dashboard and other scripts without parsing json.

* Files `sealos-manager-latest-$arch.link` contain release link to
stable packages.

* Files `sealos-manager-latest-beta-$arch.link` contain release link to
beta packages.
