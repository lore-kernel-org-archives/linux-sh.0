From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 May 2015 03:46:45 +0000
Subject: [PATCH 2/4] ASoC: rsnd: indicate unknown HW start
Message-Id: <87zj4z3oaz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87382r52x2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rsnd_ssi_hw_stop() should be called after rsnd_ssi_hw_start().
This patch indicates unknown hw_stop as error

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 sound/soc/sh/rcar/ssi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 5b89723..927ac52 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -232,8 +232,10 @@ static void rsnd_ssi_hw_stop(struct rsnd_ssi *ssi)
 	struct device *dev = rsnd_priv_to_dev(priv);
 	u32 cr;
 
-	if (0 = ssi->usrcnt) /* stop might be called without start */
+	if (0 = ssi->usrcnt) {
+		dev_err(dev, "%s called without starting\n", __func__);
 		return;
+	}
 
 	ssi->usrcnt--;
 
-- 
1.9.1

