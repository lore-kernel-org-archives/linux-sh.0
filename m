From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 10:42:22 +0000
Subject: [PATCH] ASoC: rsnd: Remove obsolete platform data support
Message-Id: <1444214542-27052-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 3d7608e4c169af03 ("ARM: shmobile: bockw: remove legacy
board file and config"), Renesas R-Car SoCs are only supported in
generic DT-only ARM multi-platform builds.  The driver doesn't need to
use platform data anymore, hence remove platform data configuration.

Move <sound/rcar_snd.h> to sound/soc/sh/rcar/, as it's no longer needed
by platform code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Commit 3d7608e4c169af03 is now in arm-soc/for-next.
---
 sound/soc/sh/rcar/core.c                        | 19 +++++--------------
 {include/sound => sound/soc/sh/rcar}/rcar_snd.h |  0
 sound/soc/sh/rcar/rsnd.h                        |  3 ++-
 sound/soc/sh/rcar/ssi.c                         |  3 ---
 4 files changed, 7 insertions(+), 18 deletions(-)
 rename {include/sound => sound/soc/sh/rcar}/rcar_snd.h (100%)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index eec294da81e3..6ef9a884ca7c 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1236,20 +1236,11 @@ static int rsnd_probe(struct platform_device *pdev)
 	};
 	int ret, i;
 
-	info = NULL;
-	of_data = NULL;
-	if (of_id) {
-		info = devm_kzalloc(&pdev->dev,
-				    sizeof(struct rcar_snd_info), GFP_KERNEL);
-		of_data = of_id->data;
-	} else {
-		info = pdev->dev.platform_data;
-	}
-
-	if (!info) {
-		dev_err(dev, "driver needs R-Car sound information\n");
-		return -ENODEV;
-	}
+	info = devm_kzalloc(&pdev->dev, sizeof(struct rcar_snd_info),
+			    GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	of_data = of_id->data;
 
 	/*
 	 *	init priv data
diff --git a/include/sound/rcar_snd.h b/sound/soc/sh/rcar/rcar_snd.h
similarity index 100%
rename from include/sound/rcar_snd.h
rename to sound/soc/sh/rcar/rcar_snd.h
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index e4068d78616c..e9fef53968b4 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -21,10 +21,11 @@
 #include <linux/of_irq.h>
 #include <linux/sh_dma.h>
 #include <linux/workqueue.h>
-#include <sound/rcar_snd.h>
 #include <sound/soc.h>
 #include <sound/pcm_params.h>
 
+#include "rcar_snd.h"
+
 /*
  *	pseudo register
  *
diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
index 5e05f9422073..842a35b1363a 100644
--- a/sound/soc/sh/rcar/ssi.c
+++ b/sound/soc/sh/rcar/ssi.c
@@ -700,9 +700,6 @@ static void rsnd_of_parse_ssi(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	int nr, i;
 
-	if (!of_data)
-		return;
-
 	node = rsnd_ssi_of_node(priv);
 	if (!node)
 		return;
-- 
1.9.1

