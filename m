From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 01 Sep 2014 23:52:29 +0000
Subject: Re: [PATCH 2/7] mmc: omap_hsmmc: use blk_size_workaround
Message-Id: <87sikakifc.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87oauzzofe.wl%kuninori.morimoto.gx@gmail.com>
	<540444FD.4040800@cogentembedded.com>
In-Reply-To: <540444FD.4040800@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Sergei

> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > index ece1634..6d2696b 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> [...]
> > @@ -1840,6 +1854,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
> >   	.get_ro = omap_hsmmc_get_ro,
> >   	.init_card = omap_hsmmc_init_card,
> >   	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
> > +	.blk_workaround = omap_hsmmc_blk_size_workaround,
> 
>     Not '.blk_size_workaround'?

Ohh my..
I noticed and fixed it in my tree,
but it seems sent old version.
Thank you for pointing it.
will fix in v2

Best regards
---
Kuninori Morimoto
