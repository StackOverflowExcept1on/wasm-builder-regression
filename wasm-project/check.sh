#!/usr/bin/env bash

RUSTFLAGS="--emit=llvm-ir" \
rustup run nightly-2025-08-07 cargo rustc \
--target=wasm32v1-none \
--color=always \
--manifest-path="$(pwd)/Cargo.toml" \
--profile release \
--verbose \
-- \
-C link-arg=--import-memory \
-C linker-plugin-lto \
-C save-temps \
--print link-args

rustup run nightly-2025-08-07 cargo run \
--release \
--manifest-path=../wasm-checker/Cargo.toml \
-- \
./target/wasm32v1-none/release/wasm_program.wasm
