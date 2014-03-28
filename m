From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 28 Mar 2014 12:27:06 +0000
Subject: [PATCH] ASoC: rsnd: SSI needs to prepare clocks before enabling
Message-Id: <1396009626-24699-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: kuninori.morimoto.gx@renesas.com, broonie@kernel.org, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, William Towle <william.towle@codethink.co.uk>

From: William Towle <william.towle@codethink.co.uk>

The rsnd_ssi_hw_{stop|start} functions need to call clk_prepare_enable()
and clk_disable_unprepare(), otherwise the following warning occurs on
attempt to play sound:

WARNING: CPU: 2 PID: 1176 at drivers/clk/clk.c:926 __clk_enable+0x30/0x9c()

due to drivers/clk/clk.c:

    926         if (WARN_ON(clk->prepare_count = 0))
    927                 return -ESHUTDOWN;

Signed-off-by: William Towle <william.towle@codethink.co.uk>
[ben.dooks@codethink.co.uk: add more bug info to report]
Tested-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 sound/soc/sh/rcar/ssi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 4b8cf7c..1c07ef7 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -250,7 +250,7 @@ static void rsnd_ssi_hw_start(struct rsnd_ssi *ssi,
 	u32 cr;
 
 	if (0 = ssi->usrcnt) {
-		clk_enable(ssi->clk);
+		clk_prepare_enable(ssi->clk);
 
 		if (rsnd_rdai_is_clk_master(rdai)) {
 			if (rsnd_ssi_clk_from_parent(ssi))
@@ -309,7 +309,7 @@ static void rsnd_ssi_hw_stop(struct rsnd_ssi *ssi,
 				rsnd_ssi_master_clk_stop(ssi);
 		}
 
-		clk_disable(ssi->clk);
+		clk_disable_unprepare(ssi->clk);
 	}
 
 	dev_dbg(dev, "ssi%d hw stopped\n", rsnd_mod_id(&ssi->mod));
-- 
1.9.0

