From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 07 Feb 2013 23:31:50 +0000
Subject: [PATCH 3/3] ARM: shmobile: SDHI and MMCIF interfaces to kzm9g-reference
Message-Id: <Pine.LNX.4.64.1302080029390.30556@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add SDHI0 and SDHI2 interfaces to kzm9g-reference. With no pinctrl DT
support we cannot use GPIO card-detection and regulator switching.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   33 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g-reference.c |   21 +++++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 06f52f9..8ccd479 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -33,6 +33,39 @@
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	fixedregulator3v3: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	sdhi0: sdhi@0xee100000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee100000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 83 4
+				0 84 4
+				0 85 4>;
+		vmmc-supply = <&fixedregulator3v3>;
+		bus-width = <4>;
+		toshiba,mmc-has-idle-wait;
+	};
+
+	sdhi2: sdhi@0xee140000 {
+		compatible = "renesas,shmobile-sdhi";
+		reg = <0xee140000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 103 4
+				0 104 4
+				0 105 4>;
+		vmmc-supply = <&fixedregulator3v3>;
+		bus-width = <4>;
+		broken-cd;
+		toshiba,mmc-wrprotect-disable;
+		toshiba,mmc-has-idle-wait;
+	};
 };
 
 &mmcif {
diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index 6a1222e..534eee6 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -52,6 +52,27 @@ static void __init kzm_init(void)
 	gpio_request(GPIO_FN_MMCD0_6_PU,	NULL);
 	gpio_request(GPIO_FN_MMCD0_7_PU,	NULL);
 
+	/* enable SD */
+	gpio_request(GPIO_FN_SDHIWP0,		NULL);
+	gpio_request(GPIO_FN_SDHICD0,		NULL);
+	gpio_request(GPIO_FN_SDHICMD0,		NULL);
+	gpio_request(GPIO_FN_SDHICLK0,		NULL);
+	gpio_request(GPIO_FN_SDHID0_3,		NULL);
+	gpio_request(GPIO_FN_SDHID0_2,		NULL);
+	gpio_request(GPIO_FN_SDHID0_1,		NULL);
+	gpio_request(GPIO_FN_SDHID0_0,		NULL);
+	gpio_request(GPIO_FN_SDHI0_VCCQ_MC0_ON,	NULL);
+	gpio_request_one(GPIO_PORT15, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+
+	/* enable Micro SD */
+	gpio_request(GPIO_FN_SDHID2_0,		NULL);
+	gpio_request(GPIO_FN_SDHID2_1,		NULL);
+	gpio_request(GPIO_FN_SDHID2_2,		NULL);
+	gpio_request(GPIO_FN_SDHID2_3,		NULL);
+	gpio_request(GPIO_FN_SDHICMD2,		NULL);
+	gpio_request(GPIO_FN_SDHICLK2,		NULL);
+	gpio_request_one(GPIO_PORT14, GPIOF_OUT_INIT_HIGH, NULL); /* power */
+
 	/* I2C 3 */
 	gpio_request(GPIO_FN_PORT27_I2C_SCL3, NULL);
 	gpio_request(GPIO_FN_PORT28_I2C_SDA3, NULL);
-- 
1.7.2.5

