#!/usr/bin/env bash

RUSTFLAGS="-Ctarget-cpu=mvp" \
rustup run nightly-2024-08-01 cargo rustc \
-Zbuild-std=core,alloc,panic_abort \
--target=wasm32-unknown-unknown \
--color=always \
--manifest-path="$(pwd)/Cargo.toml" \
--profile release \
-- \
-C link-arg=--import-memory \
-C linker-plugin-lto # try to remove this

rustup run nightly-2024-08-01 cargo run \
--release \
--manifest-path=../wasm-checker/Cargo.toml \
-- \
./target/wasm32-unknown-unknown/release/wasm_program.wasm
