#![no_std]

extern "C" {
    fn gr_panic(payload: *const u8, len: u32) -> !;
}

#[no_mangle]
extern "C" fn init() {
    panic!("msg");
}

#[panic_handler]
fn my_panic(panic_info: &core::panic::PanicInfo) -> ! {
    use arrayvec::ArrayString;
    use core::fmt::Write;

    let message = panic_info.message();
    let mut debug_msg = ArrayString::<1024>::new();

    let _ = write!(&mut debug_msg, "panicked with '{message}'");

    unsafe { gr_panic(debug_msg.as_ptr(), debug_msg.len() as u32) }
}
