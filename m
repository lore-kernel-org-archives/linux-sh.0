From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 14 Aug 2020 12:42:45 +0000
Subject: [PATCH] sh: landisk: Add missing initialization of sh_io_port_base
Message-Id: <20200814124245.29692-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Landisk setup code maps the CF IDE area using ioremap_prot(), and
passes the resulting virtual addresses to the pata_platform driver,
disguising them as I/O port addresses.  Hence the pata_platform driver
translates them again using ioport_map().
As CONFIG_GENERIC_IOMAP=n, and CONFIG_HAS_IOPORT_MAP=y, the
SuperH-specific mapping code in arch/sh/kernel/ioport.c translates
I/O port addresses to virtual addresses by adding sh_io_port_base, which
defaults to -1, thus breaking the assumption of an identity mapping.

Fix this by setting sh_io_port_base to zero.

Fixes: 37b7a97884ba64bf ("sh: machvec IO death.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on USL-5P, using either
CONFIG_ATA/CONFIG_ATA_SFF/CONFIG_PATA_PLATFORM, or legacy
CONFIG_IDE/CONFIG_BLK_DEV_PLATFORM.

Sato-san: As you said IDE works fine on Landisk using
	  CONFIG_BLK_DEV_AEC62XX, I assume you have a different model
	  than the USL-5P, with PCI IDE?
---
 arch/sh/boards/mach-landisk/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index 16b4d8b0bb8503d9..2c44b94f82fb2740 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -82,6 +82,9 @@ device_initcall(landisk_devices_setup);
 
 static void __init landisk_setup(char **cmdline_p)
 {
+	/* I/O port identity mapping */
+	__set_io_port_base(0);
+
 	/* LED ON */
 	__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
 
-- 
2.17.1
