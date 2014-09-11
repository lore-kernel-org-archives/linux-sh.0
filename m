From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 11 Sep 2014 00:57:04 +0000
Subject: [PATCH 7/7] ARM: shmobile: kzm9g-reference: Enable CMT1 in device tree
Message-Id: <48a0d1e07d99ecfd1e5922dd22986d5813f17207.1410396171.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1410396171.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1410396171.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |  4 ++++
 arch/arm/mach-shmobile/setup-sh73a0.c        | 11 +----------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 18662ae..99659db 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -173,6 +173,10 @@
 	};
 };
 
+&cmt1 {
+	status = "ok";
+};
+
 &i2c0 {
 	status = "okay";
 	as3711@40 {
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2c802ae..928e96a 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -696,10 +696,6 @@ static struct platform_device irqpin3_device = {
 	},
 };
 
-static struct platform_device *sh73a0_devices_dt[] __initdata = {
-	&cmt1_device,
-};
-
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -712,6 +708,7 @@ static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif8_device,
 	&tmu0_device,
 	&ipmmu_device,
+	&cmt1_device,
 };
 
 static struct platform_device *sh73a0_late_devices[] __initdata = {
@@ -736,8 +733,6 @@ void __init sh73a0_add_standard_devices(void)
 	/* Clear software reset bit on SY-DMAC module */
 	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
 
-	platform_add_devices(sh73a0_devices_dt,
-			    ARRAY_SIZE(sh73a0_devices_dt));
 	platform_add_devices(sh73a0_early_devices,
 			    ARRAY_SIZE(sh73a0_early_devices));
 	platform_add_devices(sh73a0_late_devices,
@@ -762,8 +757,6 @@ void __init sh73a0_earlytimer_init(void)
 
 void __init sh73a0_add_early_devices(void)
 {
-	early_platform_add_devices(sh73a0_devices_dt,
-				   ARRAY_SIZE(sh73a0_devices_dt));
 	early_platform_add_devices(sh73a0_early_devices,
 				   ARRAY_SIZE(sh73a0_early_devices));
 
@@ -780,8 +773,6 @@ void __init sh73a0_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
-	platform_add_devices(sh73a0_devices_dt,
-			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	/* Instantiate cpufreq-cpu0 */
-- 
2.0.1

