From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:33:09 +0000
Subject: [PATCH 24/24 v2] ASoC: rsnd: add sample code of reg-names
Message-Id: <87h9ugna6h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current rsnd driver supports reg-names, and Audio DMAC peri peri.
This patch adds sample code for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 .../devicetree/bindings/sound/renesas,rsnd.txt     |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 6e660d4..f316ce1 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -53,7 +53,9 @@ rcar_sound: rcar_sound@ec500000 {
 	reg =	<0 0xec500000 0 0x1000>, /* SCU */
 		<0 0xec5a0000 0 0x100>,  /* ADG */
 		<0 0xec540000 0 0x1000>, /* SSIU */
-		<0 0xec541000 0 0x1280>; /* SSI */
+		<0 0xec541000 0 0x1280>, /* SSI */
+		<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
+	reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
 
 	clocks = <&mstp10_clks R8A7790_CLK_SSI_ALL>,
 		<&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
-- 
1.7.9.5

