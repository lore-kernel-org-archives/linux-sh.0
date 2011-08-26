From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Aug 2011 04:47:00 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 LCDC1 suspend fix V2
Message-Id: <20110826044700.26275.3769.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
References: <20110824093936.8230.53081.sendpatchset@rxone.opensource.se>
In-Reply-To: <20110824093936.8230.53081.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Associate the HDMI clock together with LCDC1 on sh7372 V2.

Without this patch Suspend-to-RAM hangs on the boards
AP4EVB and Mackerel. The code hangs in the LCDC driver
where the software is waiting forever for the hardware to
power down. By explicitly associating the HDMI clock with
LCDC1 we can make sure the HDMI clock is enabled using
Runtime PM whenever the driver is accessing the hardware.

This HDMI and LCDC1 dependency is documented in the sh7372
data sheet. Older kernels did work as expected but the
recently merged (3.1-rc)

 794d78f drivers: sh: late disabling of clocks V2

introduced code to turn off clocks lacking software reference
which happens to include the HDMI clock that is needed by
LCDC1 to operate as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes V1 -> V2:
 - Use lcdc1_device on AP4EVB to build properly.

 arch/arm/mach-shmobile/board-ap4evb.c   |    1 +
 arch/arm/mach-shmobile/board-mackerel.c |    1 +
 arch/arm/mach-shmobile/clock-sh7372.c   |    2 ++
 3 files changed, 4 insertions(+)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2011-08-26 13:41:24.000000000 +0900
@@ -1412,6 +1412,7 @@ static void __init ap4evb_init(void)
 	fsi_init_pm_clock();
 	sh7372_pm_init();
 	pm_clk_add(&fsi_device.dev, "spu2");
+	pm_clk_add(&lcdc1_device.dev, "hdmi");
 }
 
 static void __init ap4evb_timer_init(void)
--- 0004/arch/arm/mach-shmobile/board-mackerel.c
+++ work/arch/arm/mach-shmobile/board-mackerel.c	2011-08-26 13:33:36.000000000 +0900
@@ -1592,6 +1592,7 @@ static void __init mackerel_init(void)
 	hdmi_init_pm_clock();
 	sh7372_pm_init();
 	pm_clk_add(&fsi_device.dev, "spu2");
+	pm_clk_add(&hdmi_lcdc_device.dev, "hdmi");
 }
 
 static void __init mackerel_timer_init(void)
--- 0005/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2011-08-26 13:33:36.000000000 +0900
@@ -659,6 +659,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
 
+	CLKDEV_ICK_ID("hdmi", "sh_mobile_lcdc_fb.1",
+		      &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_ICK_ID("ick", "sh-mobile-hdmi", &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_ICK_ID("icka", "sh_fsi2", &div6_reparent_clks[DIV6_FSIA]),
 	CLKDEV_ICK_ID("ickb", "sh_fsi2", &div6_reparent_clks[DIV6_FSIB]),
