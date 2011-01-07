From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 07 Jan 2011 02:59:46 +0000
Subject: [PATCH /RFC] sh: landisk: Fix ioremap address for CF I/O window
Message-Id: <1294369427-4149-1-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

By commit f33609344acfdde1c1acedf6de3efe6b80af93a6, it was revised
by p3_ioremap to use ioremap_prot.
However, CF I/O window is not usable because this did not map to P3 area
This changes from ioremap_prot to __ioremap.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/boards/mach-landisk/setup.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index 94186cf..e1fb98b 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -1,5 +1,5 @@
 /*
- * arch/sh/boards/landisk/setup.c
+ * arch/sh/boards/mach-landisk/setup.c
  *
  * I-O DATA Device, Inc. LANDISK Support.
  *
@@ -7,6 +7,7 @@
  * Copyright (C) 2002 Paul Mundt
  * Copylight (C) 2002 Atom Create Engineering Co., Ltd.
  * Copyright (C) 2005-2007 kogiidena
+ * Copyright (C) 2011 Nobuhiro Iwamatsu
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -17,13 +18,13 @@
 #include <linux/ata_platform.h>
 #include <linux/pm.h>
 #include <linux/mm.h>
+#include <linux/io.h>
 #include <asm/machvec.h>
 #include <mach-landisk/mach/iodata_landisk.h>
-#include <asm/io.h>
 
 static void landisk_power_off(void)
 {
-        __raw_writeb(0x01, PA_SHUTDOWN);
+	__raw_writeb(0x01, PA_SHUTDOWN);
 }
 
 static struct resource cf_ide_resources[3];
@@ -61,9 +62,10 @@ static int __init landisk_devices_setup(void)
 	/* open I/O area window */
 	paddrbase = virt_to_phys((void *)PA_AREA5_IO);
 	prot = PAGE_KERNEL_PCC(1, _PAGE_PCC_IO16);
-	cf_ide_base = ioremap_prot(paddrbase, PAGE_SIZE, pgprot_val(prot));
+	cf_ide_base +		__ioremap(paddrbase, PAGE_SIZE, __pgprot(pgprot_val(prot)));
 	if (!cf_ide_base) {
-		printk("allocate_cf_area : can't open CF I/O window!\n");
+		printk(KERN_ERR "allocate_cf_area : can't open CF I/O window!\n");
 		return -ENOMEM;
 	}
 
@@ -85,7 +87,7 @@ device_initcall(landisk_devices_setup);
 
 static void __init landisk_setup(char **cmdline_p)
 {
-        /* LED ON */
+  	/* LED ON */
 	__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
 
 	printk(KERN_INFO "I-O DATA DEVICE, INC. \"LANDISK Series\" support.\n");
@@ -97,7 +99,6 @@ static void __init landisk_setup(char **cmdline_p)
  */
 static struct sh_machine_vector mv_landisk __initmv = {
 	.mv_name = "LANDISK",
-	.mv_nr_irqs = 72,
 	.mv_setup = landisk_setup,
 	.mv_init_irq = init_landisk_IRQ,
 };
-- 
1.7.2.3

