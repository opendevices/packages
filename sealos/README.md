# Release directory

This is designed like this in case we have network outage, we can upload new updates into other location and distribute
them.

## Making releases

To publish new SealOS versions and rauc bundle updates, please follow this guide:

### 1. Stable and beta directories

Create directories here `stable` and `beta`

```
releases/beta/$MACHINE_ID/development/
releases/stable/$MACHINE_ID/production/
releases/stable/$MACHINE_ID/development/
```

Where that one is the $VARIANT_ID contains either "development" or "production" string:
https://github.com/opendevices/meta-sealos/issues/6

Development means remote root ssh enabled without password, where in production it is disabled, only ssh keys.

For paying customers we should go only with stable production base line. For development we should go with development
base line.


### 2. SealOS last version files

**From this step 2 and next steps have to be repeted each new release**

Example VERSION_ID="2.6.4" inside `/etc/os-release`, inside previous paths update the:

```
releases/stable/$MACHINE_ID/production/sealos-last-version
releases/stable/$MACHINE_ID/development/sealos-last-version
```

Write inside those files last **2.6.4**  that is inside: `/etc/os-release` directly **without** `VERSION_ID=`.
The VERSION_ID is semver format, the major is updated only on major changes, MINOR and PATCH should be updated of course
each new rauc bundle release if it is necessary.

This is used to compare if current version has to be upgraded or not.


### 3. Upload new rauc bundles here:

Example we made a new rauc bundle: `sealos-bundle-raspberrypi-cm3-20200804071141.raucb`

so: `MACHINE_ID="rasbperrypi-cm3"  and  RAUC_VERSION="20200804071141"`

```
# Create file last-version with 20200804071141 inside
releases/stable/$MACHINE_ID/development/rauc-full-update/rauc-last-version
or
releases/stable/$MACHINE_ID/production/rauc-full-update/rauc-last-version
```

Upload here the rauc bundles:

```
releases/stable/$MACHINE_ID/development/rauc-full-update/$RAUC_VERSION/sealos-bundle-$MACHINE_ID-$RAUC_VERSION.raucb
releases/stable/$MACHINE_ID/production/rauc-full-update/$RAUC_VERSION/sealos-bundle-$MACHINE_ID-$RAUC_VERSION.raucb
```


### 4. Update download links

Point download links to new rauc update bundles, by creating the following files:

```
releases/stable/$MACHINE_ID/production/rauc-full-update/20200804071141/rauc-last-version.link
releases/stable/$MACHINE_ID/development/rauc-full-update/20200804071141/rauc-last-version.link
```

These files should point to the link where to find the rauc bundle update example:
```
cat https://packages.sdk.ionoid.net/sealos/releases/stable/$MACHINE_ID/production/rauc-full-update/20200804071141/rauc-last-version.link
https://packages.sdk.ionoid.net/sealos/releases/stable/$MACHINE_ID/production/rauc-full-update/$RAUC_VERSION/sealos-bundle-$MACHINE_ID-$RAUC_VERSION.raucb
```

```
cat https://packages.sdk.ionoid.net/sealos/releases/stable/$MACHINE_ID/development/rauc-full-update/20200804071141/rauc-last-version.link
https://packages.sdk.ionoid.net/sealos/releases/stable/$MACHINE_ID/development/rauc-full-update/$RAUC_VERSION/sealos-bundle-$MACHINE_ID-$RAUC_VERSION.raucb
```
