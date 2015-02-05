From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Feb 2015 07:10:49 +0000
Subject: Re: [alsa-devel] Can we remove un-used Sound driver ?
Message-Id: <87a90sj0hy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egq7774l.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>


Hi Mark, SH ML

> We have below sound drivers in upstream kernel.
> But, these are not used from upstreamed board.
> And, these are for very old SoC.
> I guess Renesas doesn't/can't support these SoC/board anymore.
> Can we remove these sound drivers ?
> Because maintenance cost for these is not zero...

These patches remove Renesas SuperH base un-used sound drivers.
Maybe, these had been used from out-of-tree (?). But ...
 - these are for very old SoC / platform
 - these are not used/enabled from upstreamed platform
 - maintenance cost is not zero
 - we can't test/check these drivers since we don't have these board.

I'm very sad, but...
Good bye migor
Good bye sh7760
Good bye ssi
Good bye siu
Good bye hac

Kuninori Morimoto (6):
      ASoC: sh: discontinue support of migor driver
      ASoC: sh: discontinue support of sh7760-ac97 driver
      ASoC: sh: discontinue support of ssi driver
      ASoC: sh: discontinue support of siu driver
      ASoC: sh: discontinue support of hac driver
      ASoC: sh: discontinue support of dma-sh7760 driver

 arch/sh/include/asm/siu.h              |   23 -
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    1 -
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    1 -
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   31 --
 sound/soc/sh/Kconfig                   |   48 --
 sound/soc/sh/Makefile                  |   17 -
 sound/soc/sh/dma-sh7760.c              |  352 -------------
 sound/soc/sh/hac.c                     |  346 -------------
 sound/soc/sh/migor.c                   |  208 --------
 sound/soc/sh/sh7760-ac97.c             |   73 ---
 sound/soc/sh/siu.h                     |  194 --------
 sound/soc/sh/siu_dai.c                 |  858 --------------------------------
 sound/soc/sh/siu_pcm.c                 |  612 -----------------------
 sound/soc/sh/ssi.c                     |  411 ---------------
 14 files changed, 3175 deletions(-)


Best regards
---
Kuninori Morimoto
