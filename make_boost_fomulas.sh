#!/bin/bash

function make_boost()
{
  MAJOR_VERSION=$1
  shift
  MINOR_VERSION=$1
  shift
  SHA256SUM=$1
  shift

  cat ./boost_template.txt \
    | sed -e "s/MAJOR_VERSION/$MAJOR_VERSION/g" \
    | sed -e "s/MINOR_VERSION/$MINOR_VERSION/g" \
    | sed -e "s/SHA256SUM/$SHA256SUM/g" \
    > boost${MAJOR_VERSION}_${MINOR_VERSION}.rb
}

make_boost 1 47 73d62846091af316cfe4efbc112f21d02b7c2cfe8511737be5e497bcb61ce1a3
make_boost 1 48 01c8c3330a7a5013b8cfab18a3b80fcfd89001701ea5907c9ae635b97bc2c789
make_boost 1 49 a3ec4475feefa4b57c93de4c6b1bf4db1a63557c53e64b9844968c603e539bf3
make_boost 1 50 78142059e79ec3e2e0c0d8ac9d2be89f8144b975d0261effda5609718c92994e
make_boost 1 51 b0f7ecc66eb7d6ee5a865f34dbe6791dcdf0ffeac5925142deeaa67d3c8c23f5
make_boost 1 52 eea637a4ce9f9b45a0d5e00bb9462c9f084086264d85d63133dd6d240398b28f
make_boost 1 53 7c4d1515e0310e7f810cbbc19adb9b2d425f443cc7a00b4599742ee1bdfd4c39
make_boost 1 54 412d003299e72555e1e1f62f51d3b07eca2a1911e27c442ee1c08167826ef9e2
make_boost 1 55 19c4305cd6669f2216260258802a7abc73c1624758294b2cad209d45cc13a767
make_boost 1 56 f53024506c3b3a6f96520054ec82a834772720908aed6050b30f4f56722e7701
make_boost 1 57 fea9c7472f7a52cec2a1640958145b2144bf17903a21db65b95efb6ae5817fa5
make_boost 1 58 a004d9b3fa95e956383693b86fce1b68805a6f71c2e68944fa813de0fb8c8102
make_boost 1 59 47f11c8844e579d02691a607fbd32540104a9ac7a2534a8ddaef50daf502baac
make_boost 1 60 21ef30e7940bc09a0b77a6e59a8eee95f01a766aa03cdfa02f8e167491716ee4
