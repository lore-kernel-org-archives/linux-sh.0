From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 14 Jul 2015 11:59:34 +0000
Subject: [PATCH] ASoC: fsi: Remove obsolete sh_fsi2 platform_device_id entry
Message-Id: <1436875174-13960-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since the removal of the r8a7740 legacy board code in commit
1fa59bda21c7fa36 ("ARM: shmobile: Remove legacy board code for
Armadillo-800 EVA"), all former users of the "sh_fsi2" platform device
name are only supported in generic DT-only ARM multi-platform builds.
The driver doesn't need to match platform devices by name anymore, hence
remove the corresponding platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The commit mentioned above is in -next, destined for v4.3.
---
 sound/soc/sh/fsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 142c066eaee2ecb1..0215c78cbddf5491 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -1911,7 +1911,6 @@ MODULE_DEVICE_TABLE(of, fsi_of_match);
 
 static const struct platform_device_id fsi_id_table[] = {
 	{ "sh_fsi",	(kernel_ulong_t)&fsi1_core },
-	{ "sh_fsi2",	(kernel_ulong_t)&fsi2_core },
 	{},
 };
 MODULE_DEVICE_TABLE(platform, fsi_id_table);
-- 
1.9.1

