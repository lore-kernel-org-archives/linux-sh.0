From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 09 Mar 2015 20:06:54 +0000
Subject: [PATCH 1/4] ARM: shmobile: koelsch dts: Add da9210 regulator interrupt
Message-Id: <1425931617-5479-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425931617-5479-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The da9210 regulator is connected to IRQ2. Reflect this in its device
node, so the driver can use it when it gains interrupt support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 75fa9852e235455c..25ce4c71939febd0 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -587,6 +587,8 @@
 	vdd_dvfs: regulator@68 {
 		compatible = "dlg,da9210";
 		reg = <0x68>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 
 		regulator-min-microvolt = <1000000>;
 		regulator-max-microvolt = <1000000>;
-- 
1.9.1

