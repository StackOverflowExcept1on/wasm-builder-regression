#![no_std]

extern crate alloc;

use core::alloc::{GlobalAlloc, Layout};

#[global_allocator]
static ALLOC: GlobalDlmalloc = GlobalDlmalloc;

struct GlobalDlmalloc;

unsafe impl GlobalAlloc for GlobalDlmalloc {
    #[inline]
    unsafe fn alloc(&self, _layout: Layout) -> *mut u8 {
        core::ptr::null_mut()
    }

    #[inline]
    unsafe fn dealloc(&self, _ptr: *mut u8, _layout: Layout) {}
}

unsafe extern "C" {
    pub fn gr_size(length: *mut u32);
}

fn size() -> usize {
    let mut size = 0u32;
    unsafe { gr_size(&mut size as *mut u32) };
    size as usize
}

#[unsafe(no_mangle)]
extern "C" fn init() {
    let _ = alloc::vec![0u8; size()];
}

#[panic_handler]
fn my_panic(_: &core::panic::PanicInfo) -> ! {
    loop {}
}
