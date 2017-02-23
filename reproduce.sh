#!/bin/bash
set -u -e

BAD_TARGET=//tensorflow_serving/example:inception_saved_model

echo -e "\e[1;33m========== INITIALIZATION ==========\e[0m"
git submodule update --init --recursive
pushd serving/tensorflow
echo -e '\n\n\n\n\n\n\n\n\n\n' | ./configure
popd

echo -e "\e[1;33m========== BUILDING FROM THE REPOSITORY ==========\e[0m"
pushd serving
bazel build "$BAD_TARGET" --verbose_failures
popd

echo -e "\e[1;33m========== BUILDING AS EXTERNAL DEPENDENCY ==========\e[0m"
bazel build "@tf_serving$BAD_TARGET" --verbose_failures
