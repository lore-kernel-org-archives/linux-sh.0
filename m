From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:06 +0000
Subject: [PATCH 03/11] ARM: shmbobile: r8a7790.dtsi: add pci0/1/2 nodes
Message-Id: <1391595554-20640-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add nodes for USB PCI bridge devices.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Cc: devicetree@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: horms+renesas@verge.net.au
---
 arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ba0ef9a..d52d32e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -752,4 +752,34 @@
 				"rcan1", "rcan0", "qspi_mod", "i2c3", "i2c2", "i2c1", "i2c0";
 		};
 	};
+
+	pci0: pci@ee090000  {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee090000 0x0 0xc00>,
+		      <0x0 0xee080000 0x0 0x1100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	pci1: pci@ee0b0000  {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0b0000 0x0 0xc00>,
+		      <0x0 0xee0a0000 0x0 0x1100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	pci2: pci@ee0d0000  {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0d0000 0x0 0xc00>,
+		      <0x0 0xee0c0000 0x0 0x1100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
 };
-- 
1.8.5.3

