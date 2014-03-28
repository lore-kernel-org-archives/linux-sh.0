From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 28 Mar 2014 11:20:59 +0000
Subject: [PATCH] ASoC: rsnd: use fast_io for bus
Message-Id: <1396005659-14557-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: kuninori.morimoto.gx@renesas.com, broonie@kernel.org, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, Ben Dooks <ben.dooks@codethink.co.uk>

The rcar sound driver uses regmap to access registers in various parts
of the block and uses regmap to manage mappings. The regmap is created
without fast_io set, which means it locks with a mutex rather than a
lighter-spinlock.

The use of the mutex lock causes issues when the IRQ handler is entered
as the code needs to read/write register values and thus with lock
debugging enabled the system outputs a number of warnings such as:

BUG: sleeping function called from invalid context at rnel/locking/mutex.c:616

The rcar registers are all connected via APB bus and thus not that slow
to access. The fix is to set the fast_io in the code so that regmap creates
the regmap structures using the faster spinlock functions.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 sound/soc/sh/rcar/gen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
index 9094970..6468962 100644
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
1.9.0

