From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 11 Jun 2014 11:05:51 +0000
Subject: [PATCH v2 5/7] ARM: shmobile: r8a7791: Add default PCIe bus clock
Message-Id: <1402484753-7471-6-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds a default PCIe bus clock node.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
 - Use a default PCIe bus clock in the device's dtsi

 arch/arm/boot/dts/r8a7791.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1e644eb..4cff7bb 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -532,6 +532,14 @@
 			clock-output-names = "extal";
 		};
 
+		/* External PCIe clock - can be overridden by the board */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "pcie_bus";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks@e6150000 {
 			compatible = "renesas,r8a7791-cpg-clocks",
-- 
2.0.0

