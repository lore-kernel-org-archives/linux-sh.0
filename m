From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 28 May 2014 07:24:01 +0000
Subject: [PATCH 6/8] ARM: shmobile: koelsch: Add PCIe bus clock and enable PCIe device
Message-Id: <1401261843-6964-7-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 05d44f9..9ece88c 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -209,6 +209,16 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	clocks {
+		/* External PCIe bus clock */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "pcie_bus";
+		};
+	};
 };
 
 &extal_clk {
@@ -408,3 +418,7 @@
 		spi-cpha;
 	};
 };
+
+&pcie {
+	status = "okay";
+};
-- 
1.9.3

