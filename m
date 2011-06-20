From: Simon Horman <horms@verge.net.au>
Date: Mon, 20 Jun 2011 13:40:51 +0000
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Message-Id: <20110620134045.GD9325@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1308550015-15717-1-git-send-email-horms@verge.net.au>
 <1308550015-15717-4-git-send-email-horms@verge.net.au>
 <BANLkTikfMgR5AMZtq7wGKJ4LRP6yjtjhOA@mail.gmail.com>
In-Reply-To: <BANLkTikfMgR5AMZtq7wGKJ4LRP6yjtjhOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>

On Mon, Jun 20, 2011 at 04:04:04PM +0900, Magnus Damm wrote:
> On Mon, Jun 20, 2011 at 3:06 PM, Simon Horman <horms@verge.net.au> wrote:
> > Some controllers require waiting for the bus to become idle
> > before writing to some registers. I have implemented this
> > by adding a hook to sd_ctrl_write16() and implementing
> > a hook for SDHI which waits for the bus to become idle.
> >
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
> 
> Hi Simon,
> 
> Thanks for your work on this!
> 
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -55,6 +57,37 @@ static int sh_mobile_sdhi_get_cd(struct platform_device *pdev)
> >                return -ENOSYS;
> >  }
> >
> > +static void sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
> > +{
> > +       int timeout = 1000;
> > +
> > +       while (--timeout && !(sd_ctrl_read16(host, CTL_STATUS2) & (1 << 13)))
> > +               udelay(1);
> > +
> > +       if (!timeout)
> > +               dev_warn(host->pdata->dev, "timeout waiting for SD bus idle\n");
> > +
> > +}
> > +
> > +static void sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
> > +{
> > +       if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
> > +               return;
> 
> and
> 
> > @@ -86,6 +119,7 @@ static int __devinit sh_mobile_sdhi_probe(struct platform_device *pdev)
> >        mmc_data->hclk = clk_get_rate(priv->clk);
> >        mmc_data->set_pwr = sh_mobile_sdhi_set_pwr;
> >        mmc_data->get_cd = sh_mobile_sdhi_get_cd;
> > +       mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
> >        mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
> >        if (p) {
> >                mmc_data->flags = p->tmio_flags;
> 
> Doesn't it make more sense to do:
> 
> if (!(host->pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
>   mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
> 
> and skip the check inside the sh_mobile_sdhi_write16_hook() function?
> 
> No need to do that check on every register access unless really needed.

Sure, good idea.
