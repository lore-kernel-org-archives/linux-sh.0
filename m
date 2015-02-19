From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:53:53 +0000
Subject: [PATCH 19/19] ASoC: rsnd: add sample code of dma entry
Message-Id: <874mqi1rof.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rsnd driver supports Audio DMAC (via DMAEngine) /
Audio DMAC peri peri (via rsnd driver) now.
This patch adds DT binding sample code on DT binging text

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     |   46 ++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 3502d22..2414e7e 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -11,6 +11,8 @@ Required properties:
 				  required register is
 				   SRU/ADG/SSI      if generation1
 				   SRU/ADG/SSIU/SSI if generation2
+- dma				: Should contain Audio DMAC entry
+				  (Audio DMAC peri peri entry is not needed)
 - rcar_sound,ssi		: Should contain SSI feature.
 				  The number of SSI subnode should be same as HW.
 				  see below for detail.
@@ -70,6 +72,50 @@ rcar_sound: rcar_sound@ec500000 {
 			"dvc.0", "dvc.1",
 			"clk_a", "clk_b", "clk_c", "clk_i";
 
+	dmas =		<&audma0 0x01>,	<&audma1 0x02>,	<&audma0 0x15>,	<&audma1 0x16>,
+			<&audma0 0x03>,	<&audma1 0x04>,	<&audma0 0x49>,	<&audma1 0x4a>,
+			<&audma0 0x05>,	<&audma1 0x06>,	<&audma0 0x63>,	<&audma1 0x64>,
+			<&audma0 0x07>,	<&audma1 0x08>,	<&audma0 0x6f>,	<&audma1 0x70>,
+			<&audma0 0x09>,	<&audma1 0x0a>,	<&audma0 0x71>,	<&audma1 0x72>,
+			<&audma0 0x0b>,	<&audma1 0x0c>,	<&audma0 0x73>,	<&audma1 0x74>,
+			<&audma0 0x0d>,	<&audma1 0x0e>,	<&audma0 0x75>,	<&audma1 0x76>,
+			<&audma0 0x0f>,	<&audma1 0x10>,	<&audma0 0x79>,	<&audma1 0x7a>,
+			<&audma0 0x11>,	<&audma1 0x12>,	<&audma0 0x7b>,	<&audma1 0x7c>,
+			<&audma0 0x13>,	<&audma1 0x14>,	<&audma0 0x7d>,	<&audma1 0x7e>,
+
+			<&audma0 0x85>,	<&audma1 0x9a>,	<&audma0 0xbc>,
+			<&audma0 0x87>,	<&audma1 0x9c>,	<&audma0 0xbe>,
+			<&audma0 0x89>,	<&audma1 0x9e>,
+			<&audma0 0x8b>,	<&audma1 0xa0>,
+			<&audma0 0x8d>,	<&audma1 0xb0>,
+			<&audma0 0x8f>,	<&audma1 0xb2>,
+			<&audma0 0x91>,	<&audma1 0xb4>,
+			<&audma0 0x93>,	<&audma1 0xb6>,
+			<&audma0 0x95>,	<&audma1 0xb8>,
+			<&audma0 0x97>,	<&audma1 0xba>;
+
+	dma-names =	"ssi0-rx",	"ssi0-tx",	"ssiu0-rx",	"ssiu0-tx",
+			"ssi1-rx",	"ssi1-tx",	"ssiu1-rx",	"ssiu1-tx",
+			"ssi2-rx",	"ssi2-tx",	"ssiu2-rx",	"ssiu2-tx",
+			"ssi3-rx",	"ssi3-tx",	"ssiu3-rx",	"ssiu3-tx",
+			"ssi4-rx",	"ssi4-tx",	"ssiu4-rx",	"ssiu4-tx",
+			"ssi5-rx",	"ssi5-tx",	"ssiu5-rx",	"ssiu5-tx",
+			"ssi6-rx",	"ssi6-tx",	"ssiu6-rx",	"ssiu6-tx",
+			"ssi7-rx",	"ssi7-tx",	"ssiu7-rx",	"ssiu7-tx",
+			"ssi8-rx",	"ssi8-tx",	"ssiu8-rx",	"ssiu8-tx",
+			"ssi9-rx",	"ssi9-tx",	"ssiu9-rx",	"ssiu9-tx",
+
+			"src0-rx",	"src0-tx",	"dvc0-tx",
+			"src1-rx",	"src1-tx",	"dvc1-tx",
+			"src2-rx",	"src2-tx",
+			"src3-rx",	"src3-tx",
+			"src4-rx",	"src4-tx",
+			"src5-rx",	"src5-tx",
+			"src6-rx",	"src6-tx",
+			"src7-rx",	"src7-tx",
+			"src8-rx",	"src8-tx",
+			"src9-rx",	"src9-tx";
+
 	rcar_sound,dvc {
 		dvc0: dvc@0 { };
 		dvc1: dvc@1 { };
-- 
1.7.9.5

