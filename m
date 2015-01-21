From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 21 Jan 2015 16:20:58 +0000
Subject: [PATCH 07/11] ARM: shmobile: bockw: add pins and clock to ethernet controller in DT
Message-Id: <1421857262-16607-8-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Completes the Ethernet controller DT entry with pin control and clock
information.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 280a922..52086fe 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -47,8 +47,12 @@
 	};
 
 	ethernet@18300000 {
+		pinctrl-0 = <&ether_pins>;
+		pinctrl-names = "default";
+
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18300000 0x1000>;
+		clocks = <&mstp1_clks R8A7778_CLK_ETHER>;
 
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin>;
@@ -103,6 +107,11 @@
 };
 
 &pfc {
+	ether_pins: ether {
+		renesas,groups = "ether_rmii";
+		renesas,function = "ether";
+	};
+
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_a", "scif0_ctrl";
 		renesas,function = "scif0";
-- 
2.2.2

