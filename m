From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 18:01:23 +0000
Subject: [PATCH 5/9] ARM: shmbobile: r8a7790.dtsi: add pci0/1/2 nodes
Message-Id: <1394128887-4197-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, sergei.shtylyov@cogentembedded.com, magnus.damn@opensource.se, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, horms+renesas@verge.net.au

Add nodes for USB PCI bridge devices.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Cc: devicetree@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: horms+renesas@verge.net.au

Conflicts:
	arch/arm/boot/dts/r8a7790.dtsi
---
 arch/arm/boot/dts/r8a7790.dtsi | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a1e7c39..7325fee 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -763,4 +763,43 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pci0: pci@ee090000  {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee090000 0x0 0xc00>,
+		      <0x0 0xee080000 0x0 0x1100>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+	pci1: pci@ee0b0000  {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0b0000 0x0 0xc00>,
+		      <0x0 0xee0a0000 0x0 0x1100>;
+		interrupts = <0 112 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <1 1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
+
+	pci2: pci@ee0d0000  {
+		compatible = "renesas,pci-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_EHCI>;
+		reg = <0x0 0xee0d0000 0x0 0xc00>,
+		      <0x0 0xee0c0000 0x0 0x1100>;
+		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+
+		bus-range = <2 2>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+	};
 };
-- 
1.9.0

