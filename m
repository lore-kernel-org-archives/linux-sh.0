From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 23 Jul 2014 21:19:26 +0000
Subject: [PATCH] ASoC: rsnd: Protect register accesses with a spinlock instead of a mutex
Message-Id: <1406150366-10169-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The hardware registers are accessed from atomic contexts (the
rsnd_soc_dai_trigger function, for instance, is called with the PCM
substream spinlock held). They thus can't be protected by a mutex.

Protect regmap register accesses with a spinlock instead of a mutex by
setting the fast_io flag.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 sound/soc/sh/rcar/gen.c | 1 +
 1 file changed, 1 insertion(+)

An even better solution might be to use regmap-mmio instead of a custom bus.
Morimoto-san, is there anything that would prevent the driver from switching
to regmap-mmio ?

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 73ce4c9..ec9ac5e 100644
--- a/sound/soc/sh/rcar/gen.c
+++ b/sound/soc/sh/rcar/gen.c
@@ -66,6 +66,7 @@ static int rsnd_regmap_read32(void *context,
 }
 
 static struct regmap_bus rsnd_regmap_bus = {
+	.fast_io			= true,
 	.write				= rsnd_regmap_write32,
 	.read				= rsnd_regmap_read32,
 	.reg_format_endian_default	= REGMAP_ENDIAN_NATIVE,
-- 
Regards,

Laurent Pinchart

