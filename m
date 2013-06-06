From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:48:19 +0000
Subject: [PATCH v2 1/6] ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
Message-Id: <1370533704-23734-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a Device Tree node for the DMA0 controller on sh73a0 and
auxdata to supply platform data to the driver. To enable the
DMA0 controller it also has to be taken out of reset.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0.dtsi         |   36 +++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/setup-sh73a0.c |    4 +++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index b977502..e730246 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -119,6 +119,42 @@
 			      0 32 0x4>;
 	};
 
+	dma0: shdma@fe000020 {
+		compatible = "renesas,shdma";
+		reg = <0xfe000020 0x89e0>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 129 4
+				0 109 4
+				0 110 4
+				0 111 4
+				0 112 4
+				0 113 4
+				0 114 4
+				0 115 4
+				0 116 4
+				0 117 4
+				0 118 4
+				0 119 4
+				0 120 4
+				0 121 4
+				0 122 4
+				0 123 4
+				0 124 4
+				0 125 4
+				0 126 4
+				0 127 4
+				0 128 4>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14", "ch15",
+				"ch16", "ch17", "ch18", "ch19";
+		#dma-cells = <1>;
+		dma-channels = <20>;
+		dma-requests = <256>;
+	};
+
 	i2c0: i2c@e6820000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 96e7ca1e..f95ecc7 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -959,6 +959,7 @@ void __init sh73a0_add_early_devices(void)
 #ifdef CONFIG_USE_OF
 
 static const struct of_dev_auxdata sh73a0_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("renesas,shdma", 0xfe000020, "sh-dma-engine.0", &sh73a0_dmae_platform_data),
 	{},
 };
 
@@ -969,6 +970,9 @@ void __init sh73a0_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
+	/* Clear software reset bit on SY-DMAC module */
+	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
+
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table,
-- 
1.7.2.5

