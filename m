From: Rob Landley <rob@landley.net>
Date: Fri, 21 Apr 2017 06:21:48 +0000
Subject: Commit 18e8cf159177 broke qemu-system-sh4 serial input.
Message-Id: <41d6bb75-5be0-c563-0569-ea37aab58f1e@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In 4.11-rc7 the qemu serial console hangs after the first character you
type. To reproduce, configure linux with this mini.config:

CONFIG_CPU_SUBTYPE_SH7751R=y
CONFIG_MMU=y
CONFIG_MEMORY_START=0x0c000000
CONFIG_VSYSCALL=y
CONFIG_SH_FPU=y
CONFIG_SH_RTS7751R2D=y
CONFIG_RTS7751R2D_PLUS=y
CONFIG_SERIAL_SH_SCI=y
CONFIG_SERIAL_SH_SCI_CONSOLE=y
CONFIG_EARLY_PRINTK=y
CONFIG_BLK_DEV_INITRD=y"
CONFIG_RD_GZIP=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_MISC_FILESYSTEMS=y
CONFIG_DEVTMPFS=y

Using "make ARCH=sh allnoconfig KCONFIG_ALLCONFIG=mini.conf", then build
the result, then boot under qemu using the following command line:

qemu-system-sh4 -M r2d -monitor null -serial null -serial stdio
-nographic -no-reboot -append "panic=1 HOST=sh4 console=ttySC1 noiotrap"
-kernel zImage -initrd sh4-linux-musl-root.cpio.gz

You'll need a simple cpio.gz initramfs (I built one using
https://github.com/landley/mkroot and the musl-cross-make cross
compiler, the cpio.gz is ~450k or I'd attach it here).

I bisected it to commit 18e8cf159177 back in February. If you do this
with the revision _before_ that commit, typing "ls -l" and hitting enter
works fine. Afterwards you get an "l" and then it hangs. (If type enough
it'll eventually deal a burst of characters all at once, and then hang
again.)

Rob
