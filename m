From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sun, 27 Mar 2011 04:31:46 +0000
Subject: [PATCH 1/2] sh: landisk: Remove mv_nr_irqs
Message-Id: <1301200307-5321-1-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/boards/mach-landisk/setup.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index 94186cf..f1147ca 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -23,7 +23,7 @@
 
 static void landisk_power_off(void)
 {
-        __raw_writeb(0x01, PA_SHUTDOWN);
+	__raw_writeb(0x01, PA_SHUTDOWN);
 }
 
 static struct resource cf_ide_resources[3];
@@ -85,7 +85,7 @@ device_initcall(landisk_devices_setup);
 
 static void __init landisk_setup(char **cmdline_p)
 {
-        /* LED ON */
+	/* LED ON */
 	__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
 
 	printk(KERN_INFO "I-O DATA DEVICE, INC. \"LANDISK Series\" support.\n");
@@ -97,7 +97,6 @@ static void __init landisk_setup(char **cmdline_p)
  */
 static struct sh_machine_vector mv_landisk __initmv = {
 	.mv_name = "LANDISK",
-	.mv_nr_irqs = 72,
 	.mv_setup = landisk_setup,
 	.mv_init_irq = init_landisk_IRQ,
 };
-- 
1.7.4.1

