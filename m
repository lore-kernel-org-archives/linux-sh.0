From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 01 Nov 2015 19:19:36 +0000
Subject: [RFC v3 2/5] ARM: shmobile: r8a7790: add node for rwdt
Message-Id: <1446405579-5367-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Just for testing, not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e39beeefdf594b..3a62ceb692a850 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -124,6 +124,13 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	wdt0: watchdog@e6020000 {
+		compatible = "renesas,rwdt-r8a7790", "renesas,rwdt";
+		reg = <0 0xe6020000 0 0x0c>;
+		clocks = <&mstp4_clks R8A7790_CLK_RWDT>;
+		status = "disabled";
+	};
+
 	gpio0: gpio@e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
-- 
2.1.4

