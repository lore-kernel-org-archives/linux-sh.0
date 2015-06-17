From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2015 13:03:36 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a7794 dtsi: Use "arm,gic-400" for GIC
Message-Id: <1434546216-10773-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1434546216-10773-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434546216-10773-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Replace the "arm,cortex-a15-gic" compatible value for the GIC by
"arm,gic-400", as the R-Car Gen2 GIC is assumed to be a GIC-400.
This has been confirmed by reading the GICD_IIDR register (on r8a7791),
which reports 0x0200043b (GIC-400 = 0x02, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
You can read the GICD_IIDR register from U-Boot using

    md 0xf1001008 1
---
 arch/arm/boot/dts/r8a7794.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index b738194233113402..8824dbd5dbb4a5c2 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -39,7 +39,7 @@
 	};
 
 	gic: interrupt-controller@f1001000 {
-		compatible = "arm,cortex-a7-gic";
+		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
 		#address-cells = <0>;
 		interrupt-controller;
-- 
1.9.1

