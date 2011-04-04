From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 04 Apr 2011 15:08:05 +0000
Subject: [PATCH/RFC] ARM: arch-shmobile: only run HDMI init on respective
Message-Id: <Pine.LNX.4.64.1104041636280.4668@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If several boards are enabled in the kernel configuration, 
hdmi_init_pm_clock() functions from board-ap4evb.c and board-mackerel.c 
will run on any of them. Prevent this by calling these functions from the 
.init_machine() callback instead of using device_initcall().

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <damm@opensource.se>
---

Marked as RFC, until tested on mackerel

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index a94f29d..fee4f6b 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -947,7 +947,7 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&ap4evb_camera,
 };
 
-static int __init hdmi_init_pm_clock(void)
+static void __init hdmi_init_pm_clock(void)
 {
 	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
 	int ret;
@@ -988,19 +988,14 @@ static int __init hdmi_init_pm_clock(void)
 	pr_debug("PLLC2 set frequency %lu\n", rate);
 
 	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("Cannot set HDMI parent: %d\n", ret);
-		goto out;
-	}
 
 out:
 	if (!IS_ERR(hdmi_ick))
 		clk_put(hdmi_ick);
-	return ret;
 }
 
-device_initcall(hdmi_init_pm_clock);
-
 static int __init fsi_init_pm_clock(void)
 {
 	struct clk *fsia_ick;
@@ -1348,6 +1343,8 @@ static void __init ap4evb_init(void)
 	__raw_writel(srcr4 & ~(1 << 13), SRCR4);
 
 	platform_add_devices(ap4evb_devices, ARRAY_SIZE(ap4evb_devices));
+
+	hdmi_init_pm_clock();
 }
 
 static void __init ap4evb_timer_init(void)
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 49bc074..e70dd57 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -423,7 +423,7 @@ static struct platform_device fsi_hdmi_device = {
 	.name		= "sh_fsi2_b_hdmi",
 };
 
-static int __init hdmi_init_pm_clock(void)
+static void __init hdmi_init_pm_clock(void)
 {
 	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
 	int ret;
@@ -467,17 +467,13 @@ static int __init hdmi_init_pm_clock(void)
 	pr_debug("PLLC2 set frequency %lu\n", rate);
 
 	ret = clk_set_parent(hdmi_ick, &sh7372_pllc2_clk);
-	if (ret < 0) {
+	if (ret < 0)
 		pr_err("Cannot set HDMI parent: %d\n", ret);
-		goto out;
-	}
 
 out:
 	if (!IS_ERR(hdmi_ick))
 		clk_put(hdmi_ick);
-	return ret;
 }
-device_initcall(hdmi_init_pm_clock);
 
 /* USB1 (Host) */
 static void usb1_host_port_power(int port, int power)
@@ -1218,6 +1214,8 @@ static void __init mackerel_init(void)
 	sh7372_add_standard_devices();
 
 	platform_add_devices(mackerel_devices, ARRAY_SIZE(mackerel_devices));
+
+	hdmi_init_pm_clock();
 }
 
 static void __init mackerel_timer_init(void)
