From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:53:11 +0000
Subject: [PATCH 15/19] ASoC: rsnd: tidyup rcar_sound,ssi sample code
Message-Id: <87a90a1rpm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It was un-readable

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   40 +++++---------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 2dd690b..5d9a52d 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -66,36 +66,16 @@ rcar_sound: rcar_sound@ec500000 {
 	};
 
 	rcar_sound,ssi {
-		ssi0: ssi@0 {
-			interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi1: ssi@1 {
-			interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi2: ssi@2 {
-			interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi3: ssi@3 {
-			interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi4: ssi@4 {
-			interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi5: ssi@5 {
-			interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi6: ssi@6 {
-			interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi7: ssi@7 {
-			interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi8: ssi@8 {
-			interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
-		};
-		ssi9: ssi@9 {
-			interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
-		};
+		ssi0: ssi@0 { interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi1: ssi@1 { interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi2: ssi@2 { interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi3: ssi@3 { interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi4: ssi@4 { interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi5: ssi@5 { interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi6: ssi@6 { interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi7: ssi@7 { interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi8: ssi@8 { interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>; };
+		ssi9: ssi@9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
 	};
 
 	rcar_sound,dai {
-- 
1.7.9.5

