From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 16 Jan 2015 08:02:17 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <87egqvxidl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ny1ig.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ny1ig.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ulf, Simon

> > These are SDHI DMA support for r8a7790/r8a7791.
> > These are based on Ulf's
> > git://git.linaro.org/people/ulf.hansson/mmc.git :: next
> >
> > or, especially this commit
> > 5f04044fbb32cedef8cf0ea777a632882f065698
> > (mmc: sh_mobile_sdhi: tidyup mmc_data->bus_shift for latest SoC)
> >
> > Ulf, please let us know if we need to based on other branch
> 
> Please don't use my next branch, since I rebase it frequently.
> 
> I will share an immutable branch from mmc tree, called "tmio", It will
> contain only your tmio fixes. I will do this early next week since I
> want to base it on 3.19 rc5.

Thank you for your feedback !
Simon, I will re-post these patches if Ulf released tmio branch

Best regards
---
Kuninori Morimoto
