From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 12 Oct 2015 06:54:33 +0000
Subject: [RFC v2 2/5] ARM: shmobile: r8a7790: add node for rwdt
Message-Id: <1444632876-2672-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a1225e0b437fd0..3daa56e3222303 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -124,6 +124,13 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	wdt0: wdt@e6020000 {
+		compatible = "renesas,rwdt-r8a7790", "renesas,rwdt-rcar";
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

