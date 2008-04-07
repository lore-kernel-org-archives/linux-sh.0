From: "Alon Bar-Lev" <alon.barlev@gmail.com>
Date: Mon, 07 Apr 2008 13:16:01 +0000
Subject: SH7751R - STRANGE initramfs/rootfs behavior
Message-Id: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I am trying to boot 2.6.24 kernel on SH7751R big endian (sh4eb) using
embedded initramfs, anyone have this configuration working?

I use zImage converted to srec using objcopy, load the srec into
memory and jump to the load address of the kernel.

The kernel boots, but when trying to decompress the initramfs image it
 fails with "crc error",  resulting from lib/inflate.c::gunzip:1250.

Has anyone got this error? The initramfs image is correct. I also
dumped the memory of __initramfs_start->__initramfs_start and verified
that it matches the initramfs image on usr/initramfs_data.cpio.gz.

I then noticed that the kernel code at
init/initramfs::unpack_to_rootfs:459 supports handling  uncompressed
archives. So I compiled a kernel with uncompressed archived.

I also hooked the init/initramfs::do_name:585 functions, and see that
"/init' is passed to sys_open, and sys_open returns with -EOENT (-2).

 How can it be? shouldn't rootfs always be available?

 The same attempt on i586, mipsel is working as expected.

 Any ideas?
 1. Why decompression working for kernel and not for initramfs (crc error).
 2. Why files cannot be created on rootfs?

 Thank you,
Alon Bar-Lev.
