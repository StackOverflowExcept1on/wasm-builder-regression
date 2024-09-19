use gear_wasm::elements::Module;
use std::{env, error::Error, ffi::OsString, fs};

fn main() -> Result<(), Box<dyn Error>> {
    let path: Option<OsString> = env::args_os().nth(1);
    if let Some(path) = path.as_ref() {
        let input = fs::read(path)?;
        let _module = Module::from_bytes(input)?;
    }
    Ok(())
}
