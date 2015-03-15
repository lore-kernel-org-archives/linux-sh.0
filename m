From: Simon Horman <horms+renesas@verge.net.au>
Date: Sun, 15 Mar 2015 23:03:08 +0000
Subject: [PATCH 4/5] ARM: shmobile: lager dts: Add da9210 regulator interrupt
Message-Id: <ceb7747993adcc40581629e4abb0d9ea7853e857.1426456462.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1426456462.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1426456462.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The da9210 regulator is connected to IRQ2. Reflect this in its device
node, so the driver can use it when it gains interrupt support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 0c3b678..e2f4746 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -516,6 +516,8 @@
 	vdd_dvfs: regulator@68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 
 		regulator-min-microvolt = <1000000>;
 		regulator-max-microvolt = <1000000>;
-- 
2.1.4

