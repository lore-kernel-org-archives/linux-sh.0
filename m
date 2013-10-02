From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:40:20 +0000
Subject: [PATCH 4/4 v2] ARM: shmobile: marzen: fixup SMSC IRQ number on DTS
Message-Id: <8761tgysjy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixup miss-setting of SMSC IRQ number.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - patch was splited, only dts

 arch/arm/boot/dts/r8a7779-marzen-reference.dts |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 6d55083..ab4110a 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -42,8 +42,8 @@
 		pinctrl-names = "default";
 
 		phy-mode = "mii";
-		interrupt-parent = <&gic>;
-		interrupts = <0 28 0x4>;
+		interrupt-parent = <&irqpin0>;
+		interrupts = <1 0>; /* IRQ1: hwirq 1 on irqpin0 */
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
@@ -63,6 +63,10 @@
 	};
 };
 
+&irqpin0 {
+	status = "okay";
+};
+
 &pfc {
 	pinctrl-0 = <&scif2_pins &scif4_pins &sdhi0_pins>;
 	pinctrl-names = "default";
-- 
1.7.9.5

