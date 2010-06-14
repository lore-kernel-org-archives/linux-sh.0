From: Peter Huewe <PeterHuewe@gmx.de>
Date: Mon, 14 Jun 2010 15:39:41 +0000
Subject: [PATCH] soc/sh: Fix I2C dependency for SND_FSI_AK4642
Message-Id: <201006141739.42346.PeterHuewe@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org

From: Peter Huewe <peterhuewe@gmx.de>

The config option SND_FSI_AK4642 selects SND_SOC_AK464 which in turn
enables the compilation of ak4642.c - however this codec uses I2C to
communicate with the HW.

Consequently when I2C is not set, the compilation fails [1]

This patch fixes this issues.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2709408/
KernelVersion: linux-next 20100614

 sound/soc/sh/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index a1d14bc..d26b815 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -50,6 +50,7 @@ config SND_FSI_AK4642
 	bool "FSI-AK4642 sound support"
 	depends on SND_SOC_SH4_FSI
 	select SND_SOC_AK4642
+	select I2C
 	help
 	  This option enables generic sound support for the
 	  FSI - AK4642 unit
-- 
1.6.4.4

