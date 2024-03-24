# Buildroot Ext(ensions)

This repository contains custom Buildroot configurations for:

- Raspberry Pi 3B+, with real-time kernel (PREEMPT_RT patch)
- Raspberry Pi 4, with real-time kernel (PREEMPT_RT patch)


## How to use it

This repository is an add-on to Buildroot and it is meant to be configured as an external Buildroot folder defining the BR2_EXTERNAL variable, as described in the [official manual](https://buildroot.org/downloads/manual/manual.html#outside-br-custom)

```bash

git clone https://github.com/cooked/buildroot-ext.git

# get buildroot (skip if you have it already)
git clone https://github.com/buildroot/buildroot.git

cd buildroot

# use an explicit Buildroot release (optional)
git fetch --all --tags
git checkout <release_tag> -b <release_tag>

# configure the external folder (do nothing, exit without saving)
make BR2_EXTERNAL=../buildroot-ext menuconfig

# check new custom configs are listed
make list-defconfigs

# load config and build
make raspberrypi3_rt_defconfig
make
```

## Reference

Read more about [Buildroot basics](https://www.stefanocottafavi.com/buildroot_basics/) and how to [build a realtime Linux kernel](https://www.stefanocottafavi.com/buildroot_rpi_kernel_rt/) with it.
