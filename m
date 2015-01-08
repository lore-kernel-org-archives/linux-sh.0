From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Jan 2015 01:55:27 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: add SRC interrupt number on DTSI
Message-Id: <87egr6t4qy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396974957-6046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396974957-6046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2810226..272445f 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1420,16 +1420,16 @@
 		};
 
 		rcar_sound,src {
-			src0: src@0 { };
-			src1: src@1 { };
-			src2: src@2 { };
-			src3: src@3 { };
-			src4: src@4 { };
-			src5: src@5 { };
-			src6: src@6 { };
-			src7: src@7 { };
-			src8: src@8 { };
-			src9: src@9 { };
+			src0: src@0 { interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>; };
+			src1: src@1 { interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>; };
+			src2: src@2 { interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>; };
+			src3: src@3 { interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>; };
+			src4: src@4 { interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>; };
+			src5: src@5 { interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>; };
+			src6: src@6 { interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>; };
+			src7: src@7 { interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>; };
+			src8: src@8 { interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>; };
+			src9: src@9 { interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>; };
 		};
 
 		rcar_sound,ssi {
-- 
1.7.9.5

