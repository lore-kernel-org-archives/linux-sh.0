From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 09 Sep 2013 16:03:54 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7790: add I2C support in Device Tree mode
Message-Id: <1378742636-11215-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1378742636-11215-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1378742636-11215-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This patch adds clocks and clock lookup entries for the four I2C
controllers on r8a7790 and respective Device Tree nodes.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7790.dtsi         |   36 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c |   10 ++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 885f9f4..a5021112 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -127,6 +127,42 @@
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
 
+	i2c0: i2c@e6508000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-rcar-h2";
+		reg = <0 0xe6508000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 287 0x4>;
+	};
+
+	i2c1: i2c@e6518000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-rcar-h2";
+		reg = <0 0xe6518000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 288 0x4>;
+	};
+
+	i2c2: i2c@e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-rcar-h2";
+		reg = <0 0xe6530000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 286 0x4>;
+	};
+
+	i2c3: i2c@e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-rcar-h2";
+		reg = <0 0xe6540000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 290 0x4>;
+	};
+
 	mmcif0: mmcif@ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index fc36d3d..8e5e90b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -52,6 +52,7 @@
 #define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
 #define SMSTPCR8 0xe6150990
+#define SMSTPCR9 0xe6150994
 
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
@@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP813,
 	MSTP721, MSTP720,
 	MSTP717, MSTP716,
@@ -192,6 +194,10 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP931] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 31, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 30, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 29, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 28, 0), /* I2C3 */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
@@ -261,6 +267,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
+	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
-- 
1.7.2.5

