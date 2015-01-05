From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 05 Jan 2015 08:39:13 +0000
Subject: Re: [PATCH 1/9] mmc: tmio: add tmio_mmc_host_alloc/free()
Message-Id: <87h9w5oc30.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com>
	<87y4phogk8.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdWdZDVeUmM2DatvFh5ghxk-EeEq96=nh63vPpRoKaCnfg@mail.gmail.com>
In-Reply-To: <CAMuHMdWdZDVeUmM2DatvFh5ghxk-EeEq96=nh63vPpRoKaCnfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Geert

> > -int tmio_mmc_host_probe(struct tmio_mmc_host **host,
> > -                                 struct platform_device *pdev,
> > -                                 struct tmio_mmc_data *pdata)
> > +struct tmio_mmc_host*
> > +tmio_mmc_host_alloc(struct platform_device *pdev)
> 
> I think it would be better to match the naming in the mmc core layer, i.e.
> tmio_mmc_alloc_host().
> 
> >  {
> > -       struct tmio_mmc_host *_host;
> > +       struct tmio_mmc_host *host;
> >         struct mmc_host *mmc;
> > +
> > +       mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
> > +       if (!mmc)
> > +               return NULL;
> > +
> > +       host = mmc_priv(mmc);
> > +       host->mmc = mmc;
> > +       host->pdev = pdev;
> > +
> > +       return host;
> > +}
> > +
> > +void tmio_mmc_host_free(struct tmio_mmc_host *host)
> 
> tmio_mmc_free_host

I don't care so match, but these are based on tmio_mmc_host_xxx naming rule
which is used in tmio_mmc driver.

Best regards
---
Kuninori Morimoto
