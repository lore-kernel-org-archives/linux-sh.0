From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 28 May 2014 07:24:03 +0000
Subject: [PATCH 8/8] ARM: shmobile: henninger: Add dummy PCIe bus clock
Message-Id: <1401261843-6964-9-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since the CPU's dtsi refers to pcie_bus_clock, we need an entry in
the board's dts, even if we aren't using PCIe.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/r8a7791-henninger.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-henninger.dts b/arch/arm/boot/dts/r8a7791-henninger.dts
index cc6d992..6e5d779 100644
--- a/arch/arm/boot/dts/r8a7791-henninger.dts
+++ b/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -78,6 +78,16 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	clocks {
+		/* External PCIe bus clock - not used */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "pcie_bus";
+		};
+	};
 };
 
 &extal_clk {
-- 
1.9.3

