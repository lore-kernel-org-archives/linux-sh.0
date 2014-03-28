From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 28 Mar 2014 15:03:17 +0000
Subject: [PATCH] ASoC: rsnd: fix src clock prepare/unprepare
Message-Id: <1396018997-12390-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: kuninori.morimoto.gx@renesas.com, broonie@kernel.org, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, Ben Dooks <ben.dooks@codethink.co.uk>

As with the previous commit, before a clock can be used it must be prepared
for use. Change from clk_enable() and clk_disable() to the versions of the
calls which also prepare and un-prepare the clocks.

Will fix warnings from the clock code when this is used.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 sound/soc/sh/rcar/scu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rcar/scu.c b/sound/soc/sh/rcar/scu.c
index 9153a11..3b1d1d2 100644
--- a/sound/soc/sh/rcar/scu.c
+++ b/sound/soc/sh/rcar/scu.c
@@ -284,7 +284,7 @@ static int rsnd_scu_start(struct rsnd_mod *mod,
 		return 0;
 	}
 
-	clk_enable(scu->clk);
+	clk_prepare_enable(scu->clk);
 
 	/* it use DMA transter */
 
@@ -317,7 +317,7 @@ static int rsnd_scu_stop(struct rsnd_mod *mod,
 
 	rsnd_scu_transfer_stop(priv, mod, rdai, io);
 
-	clk_disable(scu->clk);
+	clk_disable_unprepare(scu->clk);
 
 	return 0;
 }
-- 
1.9.0

