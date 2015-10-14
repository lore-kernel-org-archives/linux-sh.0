From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Oct 2015 08:56:07 +0000
Subject: [PATCH] ASoC: rsnd: Announce for removing Gen1 SRU support
Message-Id: <87eggxn88u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3ldswdb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r3ldswdb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Gen1 SRU support was created for preparation of Gen2 SRC support,
but no-one is using this feature (sampling rate convert) on Gen1.
BockW had used SRU before, but it was pass through mode.
This means it is same as SSI. And BockW "platform base" code was
removed from upstream code. It is now supported via DT, but it doesn't
use SRU. More detail, r8a7778.dtsi has "rcar_sound,src" entry, but
no-one is using this feature today. SRU probing has no relation to this
removing. This means there is no effect for DT compatibility, no issues
on upstream kernel.

Gen2 SRC was created from Gen1 SRU, these are similar but not same IP.
Keeping Gen1 SRU in current driver is a little bit difficult,
and no-one is using it today. Gen1 sound is still supported via SSI.
Gen1 SRU support will be removed in the next kernel version.
This patch announces it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/sh/rcar/src.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/src.c b/sound/soc/sh/rcar/src.c
index 4507743..3fce97e 100644
--- a/sound/soc/sh/rcar/src.c
+++ b/sound/soc/sh/rcar/src.c
@@ -920,8 +920,10 @@ int rsnd_src_probe(struct platform_device *pdev,
 	int i, nr, ret;
 
 	ops = NULL;
-	if (rsnd_is_gen1(priv))
+	if (rsnd_is_gen1(priv)) {
 		ops = &rsnd_src_gen1_ops;
+		dev_warn(dev, "Gen1 support will be removed soon\n");
+	}
 	if (rsnd_is_gen2(priv))
 		ops = &rsnd_src_gen2_ops;
 	if (!ops) {
-- 
1.9.1

