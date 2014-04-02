From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 14:31:47 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: Rename VSP1_SY clocks to VSP1_S
Message-Id: <1396449107-4732-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The r8a7791 has three VSP1 instances, one of them being named VSPS (which
stands for "VSP Standard"). The clock section in the SoC datasheet
misunderstood the abbreviation as meaning VSP System, and named the
corresponding clock VSP1(SY). This mistake has been carried over to the
kernel code.

Fix this by renaming the VSP1_SY clock to VSP1_S.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 2 +-
 include/dt-bindings/clock/r8a7791-clock.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index f71670a..5f8bcd4 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -728,7 +728,7 @@
 			renesas,clock-indices = <
 				R8A7791_CLK_TMU1 R8A7791_CLK_TMU3 R8A7791_CLK_TMU2
 				R8A7791_CLK_CMT0 R8A7791_CLK_TMU0 R8A7791_CLK_VSP1_DU1
-				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_SY
+				R8A7791_CLK_VSP1_DU0 R8A7791_CLK_VSP1_S
 			>;
 			clock-output-names  				"tmu1", "tmu3", "tmu2", "cmt0", "tmu0", "vsp1-du1",
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index 2df1a11f..729dc5f 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -32,7 +32,7 @@
 #define R8A7791_CLK_TMU0		25
 #define R8A7791_CLK_VSP1_DU1		27
 #define R8A7791_CLK_VSP1_DU0		28
-#define R8A7791_CLK_VSP1_SY		31
+#define R8A7791_CLK_VSP1_S		31
 
 /* MSTP2 */
 #define R8A7791_CLK_SCIFA2		2
-- 
1.8.3.2

