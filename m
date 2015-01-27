From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 08:45:55 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: Add ethernet controller to device tree
Message-Id: <1422348356-18675-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a DT node for the on-SoC ethernet controller device.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7794.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8f78da5ef10b..68143c7ff89a 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -269,6 +269,17 @@
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
2.0.5

