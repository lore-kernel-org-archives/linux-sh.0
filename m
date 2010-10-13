From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Oct 2010 07:22:11 +0000
Subject: [PATCH] ARM: shmobile: break out sh7372 platform devices
Message-Id: <20101013072211.19725.56630.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch introduces sh7372_late_devices which
should include all regular processor specific
platform devices.

Early platform devices for console and timers
should be put on the sh7372_early_devices list,
all other devices should be on sh7372_late_devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7372.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0003/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2010-10-13 15:35:44.000000000 +0900
@@ -527,6 +527,9 @@ static struct platform_device *sh7372_ea
 	&scif5_device,
 	&scif6_device,
 	&cmt10_device,
+};
+
+static struct platform_device *sh7372_late_devices[] __initdata = {
 	&iic0_device,
 	&iic1_device,
 	&dma0_device,
@@ -538,6 +541,9 @@ void __init sh7372_add_standard_devices(
 {
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
+
+	platform_add_devices(sh7372_late_devices,
+			    ARRAY_SIZE(sh7372_late_devices));
 }
 
 void __init sh7372_add_early_devices(void)
