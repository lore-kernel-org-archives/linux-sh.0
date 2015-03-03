From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Mar 2015 01:21:14 +0000
Subject: [PATCH 3/5] ARM: shmobile: r8a7794 dtsi: Add "timer" label to the timer node
Message-Id: <54F50C8A.90203@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add "timer" label to the timer node on r8a7794.dtsi, since
the timer node is referenced from r8a7794-alt.dts.

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7794.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 7a3ffa5..937ab9e 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -82,7 +82,7 @@
 		status = "disabled";
 	};
 
-	timer {
+	timer: timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
 			     <1 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-- 
1.7.9.5

