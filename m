From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Jun 2011 00:35:34 +0000
Subject: [PATCH 02/05] ARM: mach-shmobile: sh7372 A4LC support for AP4EVB
Message-Id: <20110628003534.11399.76398.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

The AP4EVB board is also using a sh7372 SoC, so tie in
A4LC support on that board as well.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c   |    3 +++
 arch/arm/mach-shmobile/board-mackerel.c |    1 -
 arch/arm/mach-shmobile/setup-sh7372.c   |    2 ++
 3 files changed, 5 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-06-27 13:23:31.000000000 +0900
@@ -1408,6 +1408,9 @@ static void __init ap4evb_init(void)
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
 
+	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc1_device);
+	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
+
 	hdmi_init_pm_clock();
 	fsi_init_pm_clock();
 	sh7372_pm_init();
--- 0002/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-06-27 13:23:44.000000000 +0900
@@ -1582,7 +1582,6 @@ static void __init mackerel_init(void)
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
 
-	sh7372_init_pm_domain(&sh7372_a4lc);
 	sh7372_add_device_to_domain(&sh7372_a4lc, &lcdc_device);
 	sh7372_add_device_to_domain(&sh7372_a4lc, &hdmi_lcdc_device);
 
--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2011-06-27 13:23:54.000000000 +0900
@@ -841,6 +841,8 @@ static struct platform_device *sh7372_la
 
 void __init sh7372_add_standard_devices(void)
 {
+	sh7372_init_pm_domain(&sh7372_a4lc);
+
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
