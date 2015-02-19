From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:53:22 +0000
Subject: [PATCH 16/19] ASoC: rsnd: add sample code of rcar_sound,src irq
Message-Id: <878ufu1rpb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

cfcefe01265cbaf5ca7209226d043b07bfa8b587
(ASoC: rsnd: add recovery support for under/over flow error on SRC)
added SRC recovery support which needs IRQ.
This patch adds SRC irq sample code on DT bingdings text

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 5d9a52d..a5388cb 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -53,16 +53,16 @@ rcar_sound: rcar_sound@ec500000 {
 	};
 
 	rcar_sound,src {
-		src0: src@0 { };
-		src1: src@1 { };
-		src2: src@2 { };
-		src3: src@3 { };
-		src4: src@4 { };
-		src5: src@5 { };
-		src6: src@6 { };
-		src7: src@7 { };
-		src8: src@8 { };
-		src9: src@9 { };
+		src0: src@0 { interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>; };
+		src1: src@1 { interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>; };
+		src2: src@2 { interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>; };
+		src3: src@3 { interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>; };
+		src4: src@4 { interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>; };
+		src5: src@5 { interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>; };
+		src6: src@6 { interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>; };
+		src7: src@7 { interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>; };
+		src8: src@8 { interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>; };
+		src9: src@9 { interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>; };
 	};
 
 	rcar_sound,ssi {
-- 
1.7.9.5

