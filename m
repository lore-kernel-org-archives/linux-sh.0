From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 12 May 2014 23:10:20 +0000
Subject: [PATCH] ASoC: rsnd: Fix warnings due to improper printk formats
Message-Id: <1399936220-17123-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Use the %pap printk specifier to print resource_size_t variables. This
fixes warnings on platforms where resource_size_t has a different size
than int.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 sound/soc/sh/rcar/gen.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Would it be possible to get this patch in v3.16 ?

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 50a1ef3..1d5c025 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -252,13 +252,13 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
 		return ret;
 
 	dev_dbg(dev, "Gen2 device probed\n");
-	dev_dbg(dev, "SCU  : %08x => %p\n", scu_res->start,
+	dev_dbg(dev, "SCU  : %pap => %p\n", &scu_res->start,
 		gen->base[RSND_GEN2_SCU]);
-	dev_dbg(dev, "ADG  : %08x => %p\n", adg_res->start,
+	dev_dbg(dev, "ADG  : %pap => %p\n", &adg_res->start,
 		gen->base[RSND_GEN2_ADG]);
-	dev_dbg(dev, "SSIU : %08x => %p\n", ssiu_res->start,
+	dev_dbg(dev, "SSIU : %pap => %p\n", &ssiu_res->start,
 		gen->base[RSND_GEN2_SSIU]);
-	dev_dbg(dev, "SSI  : %08x => %p\n", ssi_res->start,
+	dev_dbg(dev, "SSI  : %pap => %p\n", &ssi_res->start,
 		gen->base[RSND_GEN2_SSI]);
 
 	return 0;
@@ -345,11 +345,11 @@ static int rsnd_gen1_probe(struct platform_device *pdev,
 		return ret;
 
 	dev_dbg(dev, "Gen1 device probed\n");
-	dev_dbg(dev, "SRU : %08x => %p\n",	sru_res->start,
+	dev_dbg(dev, "SRU : %pap => %p\n",	&sru_res->start,
 						gen->base[RSND_GEN1_SRU]);
-	dev_dbg(dev, "ADG : %08x => %p\n",	adg_res->start,
+	dev_dbg(dev, "ADG : %pap => %p\n",	&adg_res->start,
 						gen->base[RSND_GEN1_ADG]);
-	dev_dbg(dev, "SSI : %08x => %p\n",	ssi_res->start,
+	dev_dbg(dev, "SSI : %pap => %p\n",	&ssi_res->start,
 						gen->base[RSND_GEN1_SSI]);
 
 	return 0;
-- 
Regards,

Laurent Pinchart

