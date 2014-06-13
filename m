From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 13 Jun 2014 09:37:18 +0000
Subject: [PATCH v3 4/8] ARM: shmobile: r8a7791: Add PCIEC clock device tree node
Message-Id: <1402652242-16604-5-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds the device tree clock node for the PCIe Controller

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v3:
 - No change

v2:
 - Changed PCIe controller names,etc from pcie to pciec
 - Corrected MTSP bit ordering

 arch/arm/boot/dts/r8a7791.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7791-clock.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index b639006..1e644eb 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -772,15 +772,16 @@
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
 			clocks = <&cp_clk>, <&sd2_clk>, <&sd1_clk>, <&cpg_clocks R8A7791_CLK_SD0>,
-				 <&mmc0_clk>, <&hp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
+				 <&mmc0_clk>, <&hp_clk>, <&mp_clk>, <&hp_clk>, <&mp_clk>, <&rclk_clk>;
 			#clock-cells = <1>;
 			renesas,clock-indices = <
 				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1 R8A7791_CLK_SDHI0
-				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_IIC1 R8A7791_CLK_SSUSB R8A7791_CLK_CMT1
+				R8A7791_CLK_MMCIF0 R8A7791_CLK_IIC0 R8A7791_CLK_PCIEC R8A7791_CLK_IIC1
+				R8A7791_CLK_SSUSB R8A7791_CLK_CMT1
 			>;
 			clock-output-names  				"tpu0", "sdhi2", "sdhi1", "sdhi0",
-				"mmcif0", "i2c7", "i2c8", "ssusb", "cmt1";
+				"mmcif0", "i2c7", "pciec", "i2c8", "ssusb", "cmt1";
 		};
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index b050d18..1101e64 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -53,6 +53,7 @@
 #define R8A7791_CLK_SDHI0		14
 #define R8A7791_CLK_MMCIF0		15
 #define R8A7791_CLK_IIC0		18
+#define R8A7791_CLK_PCIEC		19
 #define R8A7791_CLK_IIC1		23
 #define R8A7791_CLK_SSUSB		28
 #define R8A7791_CLK_CMT1		29
-- 
2.0.0

