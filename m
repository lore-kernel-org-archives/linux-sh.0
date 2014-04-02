From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 14:31:46 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: Rename VSP1_(SY|RT) clocks to VSP1_(S|R)
Message-Id: <1396449107-4732-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The r8a7790 has four VSP1 instances, two of them being named VSPS (which
stands for "VSP Standard") and VSPR (which stands for "VSP for
Resizing"). The clock section in the SoC datasheet misunderstood the
abbreviations as meaning VSP System and VSP Realtime, and named the
corresponding clocks VSP1(SY) and VSP1(RT). This mistake has been
carried over to the kernel code.

Fix this by renaming the VSP1_SY and VSP1_RT clocks to VSP1_S and VSP1_R.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 2 +-
 include/dt-bindings/clock/r8a7790-clock.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index da69afc..da665fa 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -678,7 +678,7 @@
 			renesas,clock-indices = <
 				R8A7790_CLK_TMU1 R8A7790_CLK_TMU3 R8A7790_CLK_TMU2
 				R8A7790_CLK_CMT0 R8A7790_CLK_TMU0 R8A7790_CLK_VSP1_DU1
-				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_RT R8A7790_CLK_VSP1_SY
+				R8A7790_CLK_VSP1_DU0 R8A7790_CLK_VSP1_R R8A7790_CLK_VSP1_S
 			>;
 			clock-output-names  				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 6548a5f..9a7c4c5 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -33,8 +33,8 @@
 #define R8A7790_CLK_TMU0		25
 #define R8A7790_CLK_VSP1_DU1		27
 #define R8A7790_CLK_VSP1_DU0		28
-#define R8A7790_CLK_VSP1_RT		30
-#define R8A7790_CLK_VSP1_SY		31
+#define R8A7790_CLK_VSP1_R		30
+#define R8A7790_CLK_VSP1_S		31
 
 /* MSTP2 */
 #define R8A7790_CLK_SCIFA2		2
-- 
1.8.3.2

