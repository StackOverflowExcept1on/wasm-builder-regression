#!/usr/bin/env bash

RUSTFLAGS="--emit=llvm-ir" \
RUSTC_LOG="rustc_codegen_ssa::back::link=info" \
rustup run nightly-2025-08-11 cargo rustc \
--target=wasm32v1-none \
--color=always \
--manifest-path="$(pwd)/Cargo.toml" \
--profile release \
--verbose \
-- \
-C link-arg=--import-memory \
-C link-arg=--verbose \
-C linker-plugin-lto \
-C save-temps \
--print link-args

rustup run nightly-2025-08-11 cargo run \
--release \
--manifest-path=../wasm-checker/Cargo.toml \
-- \
./target/wasm32v1-none/release/wasm_program.wasm
