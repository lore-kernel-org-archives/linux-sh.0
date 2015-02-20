From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:32:49 +0000
Subject: [PATCH 23/24 v2] ASoC: rsnd: add sample code of dma entry
Message-Id: <87ioewna71.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rsnd driver supports Audio DMAC (via DMAEngine) /
Audio DMAC peri peri (via rsnd driver) now.
This patch adds DT binding sample code on DT binging text

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 ->v2

 - subnode version

 .../devicetree/bindings/sound/renesas,rsnd.txt     |   60 ++++++++++++++++=
+++-
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Doc=
umentation/devicetree/bindings/sound/renesas,rsnd.txt
index 503967b..6e660d4 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -29,9 +29,17 @@ SSI subnode properties:
 - shared-pin			: if shared clock pin
 - pio-transfer			: use PIO transfer mode
 - no-busif			: BUSIF is not ussed when [mem -> SSI] via DMA case
+- dma				: Should contain Audio DMAC entry
+- dma-names			: SSI  case "rx"  (=3Dplayback), "tx"  (=CApture)
+				  SSIU case "rxu" (=3Dplayback), "txu" (=CApture)
=20
 SRC subnode properties:
-no properties at this point
+- dma				: Should contain Audio DMAC entry
+- dma-names			: "rx" (=3Dplayback), "tx" (=CApture)
+
+DVC subnode properties:
+- dma				: Should contain Audio DMAC entry
+- dma-names			: "tx" (=3Dplayback/capture)
=20
 DAI subnode properties:
 - playback			: list of playback modules
@@ -69,73 +77,119 @@ rcar_sound: rcar_sound@ec500000 {
 			"clk_a", "clk_b", "clk_c", "clk_i";
=20
 	rcar_sound,dvc {
-		dvc0: dvc@0 { };
-		dvc1: dvc@1 { };
+		dvc0: dvc@0 {
+			dmas =3D <&audma0 0xbc>;
+			dma-names =3D "tx";
+		};
+		dvc1: dvc@1 {
+			dmas =3D <&audma0 0xbe>;
+			dma-names =3D "tx";
+		};
 	};
=20
 	rcar_sound,src {
 		src0: src@0 {
 			interrupts =3D <0 352 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x85>, <&audma1 0x9a>;
+			dma-names =3D "rx", "tx";
 		};
 		src1: src@1 {
 			interrupts =3D <0 353 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x87>, <&audma1 0x9c>;
+			dma-names =3D "rx", "tx";
 		};
 		src2: src@2 {
 			interrupts =3D <0 354 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x89>, <&audma1 0x9e>;
+			dma-names =3D "rx", "tx";
 		};
 		src3: src@3 {
 			interrupts =3D <0 355 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x8b>, <&audma1 0xa0>;
+			dma-names =3D "rx", "tx";
 		};
 		src4: src@4 {
 			interrupts =3D <0 356 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x8d>, <&audma1 0xb0>;
+			dma-names =3D "rx", "tx";
 		};
 		src5: src@5 {
 			interrupts =3D <0 357 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x8f>, <&audma1 0xb2>;
+			dma-names =3D "rx", "tx";
 		};
 		src6: src@6 {
 			interrupts =3D <0 358 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x91>, <&audma1 0xb4>;
+			dma-names =3D "rx", "tx";
 		};
 		src7: src@7 {
 			interrupts =3D <0 359 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x93>, <&audma1 0xb6>;
+			dma-names =3D "rx", "tx";
 		};
 		src8: src@8 {
 			interrupts =3D <0 360 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x95>, <&audma1 0xb8>;
+			dma-names =3D "rx", "tx";
 		};
 		src9: src@9 {
 			interrupts =3D <0 361 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x97>, <&audma1 0xba>;
+			dma-names =3D "rx", "tx";
 		};
 	};
=20
 	rcar_sound,ssi {
 		ssi0: ssi@0 {
 			interrupts =3D <0 370 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi1: ssi@1 {
 			interrupts =3D <0 371 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi2: ssi@2 {
 			interrupts =3D <0 372 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi3: ssi@3 {
 			interrupts =3D <0 373 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi4: ssi@4 {
 			interrupts =3D <0 374 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi5: ssi@5 {
 			interrupts =3D <0 375 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi6: ssi@6 {
 			interrupts =3D <0 376 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi7: ssi@7 {
 			interrupts =3D <0 377 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi8: ssi@8 {
 			interrupts =3D <0 378 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 		ssi9: ssi@9 {
 			interrupts =3D <0 379 IRQ_TYPE_LEVEL_HIGH>;
+			dmas =3D <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
+			dma-names =3D "rx", "tx", "rxu", "txu";
 		};
 	};
=20
--=20
1.7.9.5

