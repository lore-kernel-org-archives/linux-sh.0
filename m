From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:24:52 +0000
Subject: [PATCH 07/24 v2] ASoC: rsnd: enable to get resource by name
Message-Id: <8761awop4q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

rsnd driver needs to support Audio DMAC peri peri inside sound driver.
getting resource by name is useful for it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 sound/soc/sh/rcar/gen.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index de0685f..d08bcd3 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -118,11 +118,12 @@ void rsnd_bset(struct rsnd_priv *priv, struct rsnd_mod *mod,
 				  mask, data);
 }
 
-#define rsnd_gen_regmap_init(priv, id_size, reg_id, conf)		\
-	_rsnd_gen_regmap_init(priv, id_size, reg_id, conf, ARRAY_SIZE(conf))
+#define rsnd_gen_regmap_init(priv, id_size, reg_id, name, conf)		\
+	_rsnd_gen_regmap_init(priv, id_size, reg_id, name, conf, ARRAY_SIZE(conf))
 static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
 				 int id_size,
 				 int reg_id,
+				 const char *name,
 				 struct rsnd_regmap_field_conf *conf,
 				 int conf_size)
 {
@@ -142,7 +143,9 @@ static int _rsnd_gen_regmap_init(struct rsnd_priv *priv,
 	regc.val_bits = 32;
 	regc.reg_stride = 4;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, reg_id);
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!res)
+		res = platform_get_resource(pdev, IORESOURCE_MEM, reg_id);
 	if (!res)
 		return -ENODEV;
 
@@ -368,10 +371,10 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
 	int ret_adg;
 	int ret_ssi;
 
-	ret_ssiu = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_SSIU, conf_ssiu);
-	ret_scu  = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_SCU,  conf_scu);
-	ret_adg  = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_ADG,  conf_adg);
-	ret_ssi  = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_SSI,  conf_ssi);
+	ret_ssiu = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_SSIU, "ssiu", conf_ssiu);
+	ret_scu  = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_SCU,  "scu",  conf_scu);
+	ret_adg  = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_ADG,  "adg",  conf_adg);
+	ret_ssi  = rsnd_gen_regmap_init(priv, 10, RSND_GEN2_SSI,  "ssi",  conf_ssi);
 	if (ret_ssiu < 0 ||
 	    ret_scu  < 0 ||
 	    ret_adg  < 0 ||
@@ -440,9 +443,9 @@ static int rsnd_gen1_probe(struct platform_device *pdev,
 	int ret_adg;
 	int ret_ssi;
 
-	ret_sru  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_SRU,  conf_sru);
-	ret_adg  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_ADG,  conf_adg);
-	ret_ssi  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_SSI,  conf_ssi);
+	ret_sru  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_SRU, "sru", conf_sru);
+	ret_adg  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_ADG, "adg", conf_adg);
+	ret_ssi  = rsnd_gen_regmap_init(priv, 9, RSND_GEN1_SSI, "ssi", conf_ssi);
 	if (ret_sru  < 0 ||
 	    ret_adg  < 0 ||
 	    ret_ssi  < 0)
-- 
1.7.9.5

