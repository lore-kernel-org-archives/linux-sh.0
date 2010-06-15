From: Peter Huewe <PeterHuewe@gmx.de>
Date: Tue, 15 Jun 2010 15:38:55 +0000
Subject: [PATCH v2] soc/sh: Fix I2C dependency for SND_FSI_AK4642 and SND_FSI_DA7210
Message-Id: <201006151738.56143.PeterHuewe@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201006141739.42346.PeterHuewe@gmx.de> <201006151649.07554.PeterHuewe@gmx.de> <20100615151913.GJ14510@rakim.wolfsonmicro.main>
In-Reply-To: <20100615151913.GJ14510@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, linux-sh@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

From: Peter Huewe <peterhuewe@gmx.de>

The config option SND_FSI_AK4642 selects SND_SOC_AK4642 which in turn
enables the compilation of ak4642.c - however this codec uses I2C to
communicate with the HW.
Same applies to DA7210.

Consequently when I2C is not set, the compilation fails [1]

This patch fixes this issues, by adding a depencdency on the related HW-
controller.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
How about this one?

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2709408/
KernelVersion: linux-next 20100615

 sound/soc/sh/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index a1d14bc..52d7e8e 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -48,7 +48,7 @@ config SND_SH7760_AC97
 
 config SND_FSI_AK4642
 	bool "FSI-AK4642 sound support"
-	depends on SND_SOC_SH4_FSI
+	depends on SND_SOC_SH4_FSI && I2C_SH_MOBILE
 	select SND_SOC_AK4642
 	help
 	  This option enables generic sound support for the
@@ -56,7 +56,7 @@ config SND_FSI_AK4642
 
 config SND_FSI_DA7210
 	bool "FSI-DA7210 sound support"
-	depends on SND_SOC_SH4_FSI
+	depends on SND_SOC_SH4_FSI && I2C_SH_MOBILE
 	select SND_SOC_DA7210
 	help
 	  This option enables generic sound support for the
-- 
1.6.4.4

