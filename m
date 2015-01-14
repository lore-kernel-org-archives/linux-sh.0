From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 Jan 2015 08:57:24 +0000
Subject: Re: [PATCH] mmc: tmio: add missing EXPORT_SYMBOL for tmio_mmc_host_alloc/free
Message-Id: <87mw5lpwma.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201501131902.WqokttpY%fengguang.wu@intel.com>
	<87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<CAPDyKFrNFr493FcN3A3k_tGo9J801ga91ooL=sZT6DS0vFwVoQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrNFr493FcN3A3k_tGo9J801ga91ooL=sZT6DS0vFwVoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>


Hi Ulf

> > tmio_mmc_host_alloc/free were added on tmio_mmc_pio.c,
> > but, it is missing EXPORT_SYMBOL for it.
> > Compile will be failed without this patch
> >
> >  ERROR: "tmio_mmc_host_free" [drivers/mmc/host/tmio_mmc.ko] undefined!
> >  ERROR: "tmio_mmc_host_alloc" [drivers/mmc/host/tmio_mmc.ko] undefined!
> >  ERROR: "tmio_mmc_host_free" [drivers/mmc/host/sh_mobile_sdhi.ko] undefined!
> >  ERROR: "tmio_mmc_host_alloc" [drivers/mmc/host/sh_mobile_sdhi.ko] undefined!
> >
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Thanks!
> 
> I decided to squashed this change into patch "mmc: tmio: add
> tmio_mmc_host_alloc/free()", which was the one adding the related
> functions.

Thank you
good idea :)

Best regards
---
Kuninori Morimoto
