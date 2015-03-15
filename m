From: Simon Horman <horms+renesas@verge.net.au>
Date: Sun, 15 Mar 2015 23:03:09 +0000
Subject: [PATCH 5/5] ARM: shmobile: lager: Add da9063 PMIC device node for system restart
Message-Id: <46dd8a809effdc7ebe6ec760e3e421d5ac2a40f1.1426456462.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1426456462.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1426456462.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a device node for the da9063 PMIC, with subnodes for rtc and wdt.
Regulator support is not yet included.

This allows the system to be restarted when the watchdog timer times
out, or when a system restart is requested.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e2f4746..2a0f895 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -513,6 +513,22 @@
 	pinctrl-0 = <&iic3_pins>;
 	status = "okay";
 
+	pmic@58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+	};
+
 	vdd_dvfs: regulator@68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
-- 
2.1.4

