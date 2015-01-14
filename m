From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 14 Jan 2015 11:13:01 +0000
Subject: [PATCH 3/4] ARM: shmobile: r8a7740 dtsi: Add memory-controller node
Message-Id: <1421233982-15883-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421233982-15883-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add a device node for the DDR3 Bus State Controller (DBSC3).
The DBSC3 is located in the A4S PM domain, which must not be powered
down, else the system will crash.

This has no visible effect for now, as A4S was never turned off anyway
because its child PM domain A3SM contains the CPU core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 52f2cf4b84d3ccb4..8a092605d641f7d4 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -37,6 +37,12 @@
 		      <0xc2000000 0x1000>;
 	};
 
+	dbsc3: memory-controller@fe400000 {
+		compatible = "renesas,dbsc3-r8a7740";
+		reg = <0xfe400000 0x400>;
+		power-domains = <&pd_a4s>;
+	};
+
 	pmu {
 		compatible = "arm,cortex-a9-pmu";
 		interrupts = <0 83 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1

