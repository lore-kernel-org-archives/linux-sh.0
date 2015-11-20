From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Nov 2015 12:36:55 +0000
Subject: [PATCH 4/6] ARM: shmobile: r8a7778 dtsi: Use "arm,pl390" for GIC
Message-Id: <1448023017-21816-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448023017-21816-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Replace the "arm,cortex-a9-gic" compatible value for the GIC by
"arm,pl390", as the documentation states it is a PL390.
This has been confirmed by reading the GICD_IIDR register, which reports
0x0000043b (PL390 = 0x00, ARM = 0x43b).

This has no effect on runtime behavior, as currently the GIC driver
treats both compatible values the same.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
You can read the GICD_IIDR register from U-Boot using

    md 0xfe438008 1
---
 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index da76f5d95875ce11..fd10197c7dba6d7d 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -61,7 +61,7 @@
 	};
 
 	gic: interrupt-controller@fe438000 {
-		compatible = "arm,cortex-a9-gic";
+		compatible = "arm,pl390";
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0xfe438000 0x1000>,
-- 
1.9.1

