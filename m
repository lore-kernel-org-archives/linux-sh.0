From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Feb 2015 06:21:13 +0000
Subject: [PATCH 16/32] ARM: shmobile: r8a7794: Add ethernet controller to device tree
Message-Id: <82818d3482badfa88f66b3abbac838daf7e35b97.1424849129.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a DT node for the on-SoC ethernet controller device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 6f70bc4..63b918b 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -329,6 +329,17 @@
 		status = "disabled";
 	};
 
+	ether: ethernet@ee700000 {
+		compatible = "renesas,ether-r8a7794";
+		reg = <0 0xee700000 0 0x400>;
+		interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp8_clks R8A7794_CLK_ETHER>;
+		phy-mode = "rmii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.1.4

