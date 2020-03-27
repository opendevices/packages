# Release directory

To publish a new `sealos-manager` release, example release="v0.1"

1. Add directory here `download/beta/v0.1` for beta and `download/stable/v0.1` for stable.

2. Add sealos manager corresponding zipped versions into directory "v0.1" in download/beta/v0.1/

```bash
cp sealos-manager-v0.1-linux-amd64.zip $path/download/beta/v0.1/
```

3. Run the `deploy.bash` release script from this directory.

## Stable release

```bash
release="$version" stable="true" ./deploy.bash
```

```bash
release="v0.1" stable="true" ./deploy.bash
```

## Beta release

```bash
release="$version" ./deploy.bash
```

```bash
release="v0.1" ./deploy.bash
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
