From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 30 Jul 2013 17:57:22 +0000
Subject: [RFC 0/5] Non-functional zboot implementation for KZM9G
Message-Id: <1375207047-8655-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This is an attempt to implement zboot on the KZM9G board. It is based on the
setup code from u-boot and is intended to be loaded to MERAM via USB and
booted by the mask ROM boot loader.

The problem is that the DRAM setup appears to be wrong somehow. Even though
it slavishly follows the example set by u-boot it fails to set the DRAM up
in a stable manner for some reason.  The effect observed is that many
consecutive writes to DRAM in most cases cause the system to hang.  In the
few cases it doesn't the data written cannot be read back correctly.

I have tried yanking every bit in the SBSC back and forth (see the
commented-out lines in head-kzm9g.txt for details), but the DRAM stays flaky
in exactly the same way.  I suspect that the mask ROM boot loader does
something to the hardware that interferes with DRAM operation.  The sh73a0
documentation details what the loader is supposed to be doing, and I have
tried to revert the few things that are not overridden by the u-boot setup
anyway, but that didn't to anything either.

If you want to give it a try, apply the patches and configure your kernel
with CONFIG_ZBOOT_ROM_BSS=0xe5580000 and CONFIG_ZBOOT_ROM=y.  You will have
to disable a lot of features because MERAM is only 1.5 MB, and the entire
image will have to fit in there.  Don't forget to append the DTB.  Set the
mode switch (SW1) positions 1, 2, and 8 to OFF, all others to ON.  Then
upload the zImage using Magnus' r_usb_tool.  If LEDs 1-4 light up and then
turn off one by one, your board works better than mine.  If only LED 1 turns
off or the LEDs start blinking crazy bit patterns, it exhibits the same
behavior as mine.

Ideas what could be wrong here are most welcome.

CU
Uli


Ulrich Hecht (5):
  USB boot tool for SH-Mobile ARM SoCs
  arm: boot: allow zboot with appended DTB
  arm: shmobile: KZM9G zboot support (not working)
  arm: boot: kzm9g: blink LEDs and check if DRAM works
  arm: boot: kzm9g: raise core voltage

 Documentation/arm/SH-Mobile/r_usb_boot.c           |  544 ++++++++++++++++
 arch/arm/Kconfig                                   |    2 +-
 arch/arm/boot/compressed/misc.c                    |  327 +++++++++-
 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt |  680 ++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/zboot.h        |    6 +
 5 files changed, 1556 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/arm/SH-Mobile/r_usb_boot.c
 create mode 100644 arch/arm/mach-shmobile/include/mach/head-kzm9g.txt

-- 
1.7.10.4

