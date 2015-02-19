From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:53:32 +0000
Subject: [PATCH 17/19] ASoC: rsnd: add sample code of reg-names
Message-Id: <877fve1rp1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current rsnd driver supports reg-names, and Audio DMAC peri peri.
This patch adds sample code for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/sound/renesas,rsnd.txt     |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index a5388cb..5e0e107 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -45,7 +45,9 @@ rcar_sound: rcar_sound@ec500000 {
 	reg =	<0 0xec500000 0 0x1000>, /* SCU */
 		<0 0xec5a0000 0 0x100>,  /* ADG */
 		<0 0xec540000 0 0x1000>, /* SSIU */
-		<0 0xec541000 0 0x1280>; /* SSI */
+		<0 0xec541000 0 0x1280>, /* SSI */
+		<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+	reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 	rcar_sound,dvc {
 		dvc0: dvc@0 { };
-- 
1.7.9.5

