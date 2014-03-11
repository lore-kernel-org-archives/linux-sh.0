From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 11 Mar 2014 21:24:38 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a7790: add IIC(B) cores to dtsi
Message-Id: <1394573078-20767-6-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1394573078-20767-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9e15fb9858e7..5b357480d8bf 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -24,6 +24,10 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
 		spi0 = &qspi;
 		spi1 = &msiof0;
 		spi2 = &msiof1;
@@ -236,6 +240,46 @@
 		status = "disabled";
 	};
 
+	i2c4: i2c@e6500000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x425>;
+		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
+		status = "disabled";
+	};
+
+	i2c5: i2c@e6510000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		reg = <0 0xe6510000 0 0x425>;
+		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_IIC1>;
+		status = "disabled";
+	};
+
+	i2c6: i2c@e6520000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		reg = <0 0xe6520000 0 0x425>;
+		interrupts = <0 176 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_IIC2>;
+		status = "disabled";
+	};
+
+	i2c7: i2c@e60b0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
+		reg = <0 0xe60b0000 0 0x425>;
+		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7790_CLK_IICDVFS>;
+		status = "disabled";
+	};
+
 	mmcif0: mmcif@ee200000 {
 		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
1.9.0

