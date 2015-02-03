From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 03 Feb 2015 08:03:58 +0000
Subject: Can we remove un-used Sound driver ?
Message-Id: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>


Hi SH ML, ALSA ML

We have below sound drivers in upstream kernel.
But, these are not used from upstreamed board.
And, these are for very old SoC.
I guess Renesas doesn't/can't support these SoC/board anymore.
Can we remove these sound drivers ?
Because maintenance cost for these is not zero...

- ${LINUX}/sound/soc/sh/ssi.c
  - SH7760/SH7780
  - CONFIG_SND_SOC_SH4_SSI

- ${LINUX}/linux/sound/soc/sh/hac.c
  - SH7760/SH7780
  - CONFIG_SND_SOC_SH4_HAC

- ${LINUX}/sound/soc/sh/sh7760-ac97.c
  - SH7760
  - CONFIG_SND_SH7760_AC97

- ${LINUX}/sound/soc/sh/dma-sh7760.c
  - SH7760
  - CONFIG_SND_SOC_PCM_SH7760

- ${LINUX}/sound/soc/sh/siu_dai.c  *1
  ${LINUX}/sound/soc/sh/siu_pcm.c
  ${LINUX}/sound/soc/sh/siu.h
  - SH7343, SH7722
  - CONFIG_SND_SOC_SH4_SIU

- ${LINUX}/sound/soc/sh/migor.c  *2
  - SH7722
  - CONFIG_SND_SIU_MIGOR

*1
  it is registered from ${LINUX}/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
  but, no one enabled CONFIG_SND_SOC_SH4_SIU in defconfig

*2
  it uses *1, but no one enabled CONFIG_SND_SIU_MIGOR

Best regards
---
Kuninori Morimoto
