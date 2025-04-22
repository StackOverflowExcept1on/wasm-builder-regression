#!/usr/bin/env bash

RUSTFLAGS="--emit=llvm-ir" \
rustup run nightly-2025-04-22 cargo rustc \
--target=wasm32v1-none \
--color=always \
--manifest-path="$(pwd)/Cargo.toml" \
--profile release \
-- \
-C link-arg=--import-memory \
-C linker-plugin-lto # try to remove this

rustup run nightly-2025-04-22 cargo run \
--release \
--manifest-path=../wasm-checker/Cargo.toml \
-- \
./target/wasm32v1-none/release/wasm_program.wasm
