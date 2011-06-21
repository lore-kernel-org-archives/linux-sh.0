From: Simon Horman <horms@verge.net.au>
Date: Tue, 21 Jun 2011 02:09:20 +0000
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Message-Id: <20110621020913.GE16230@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
 <1308610812-3479-4-git-send-email-horms@verge.net.au>
 <BANLkTikh9D=uaGmZ5BCMPmESexjDSczwhg@mail.gmail.com>
 <20110621005020.GB16230@verge.net.au>
 <BANLkTimRUnaMtk_zhLAquAKQre4E8ZJUJQ@mail.gmail.com>
 <20110621011257.GD16230@verge.net.au>
 <BANLkTike6dkPPet5miiSzVGjRPCKoM7cyg@mail.gmail.com>
In-Reply-To: <BANLkTike6dkPPet5miiSzVGjRPCKoM7cyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>

On Tue, Jun 21, 2011 at 10:36:05AM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, Jun 21, 2011 at 10:13 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Jun 21, 2011 at 09:59:37AM +0900, Magnus Damm wrote:
> >> On Tue, Jun 21, 2011 at 9:50 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > On Tue, Jun 21, 2011 at 09:36:03AM +0900, Magnus Damm wrote:
> >> >> On Tue, Jun 21, 2011 at 8:00 AM, Simon Horman <horms@verge.net.au> wrote:
> >
> > [snip]
> >
> >> >> > index 5a90266..0dc9804 100644
> >> >> > --- a/include/linux/mfd/tmio.h
> >> >> > +++ b/include/linux/mfd/tmio.h
> >> >> > @@ -94,6 +101,7 @@ struct tmio_mmc_data {
> >> >> >        void (*set_pwr)(struct platform_device *host, int state);
> >> >> >        void (*set_clk_div)(struct platform_device *host, int state);
> >> >> >        int (*get_cd)(struct platform_device *host);
> >> >> > +       int (*write16_hook)(struct tmio_mmc_host *host, int addr);
> >> >> >  };
> >> >> >
> >> >> >  static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *pdata)
> >> >>
> >> >> What's the reason behind passing "struct tmio_mmc_host *"  as an
> >> >> argument to the new hook? Performance? All other callbacks seem to
> >> >> take a "struct platform_device *", so being consistent here may be
> >> >> good unless it comes with too much overhead.
> >> >
> >> > The reason is that
> >> > 1) The hook is called from sd_ctrl_write16 which takes
> >> >   struct tmio_mmc_host * as its first argument and;
> >> > 2) The hook that has been implemented calls sd_ctrl_read16() which takes a
> >> >   struct tmio_mmc_host * as its first argument.
> >> > So it seemed logical to pass that down.
> >> >
> >> > In the caes of 1) we can get the struct platform_device * using host->pdev.
> >> > However, in the case of 2) is it less clear to me how we can get the
> >> > struct tmio_mmc_host * from a struct platform_device *.
> >>
> >> Have a look at the code in tmio_mmc_host_suspend() for some code that
> >> does struct device * -> struct tmio_mmc_host *:
> >> int tmio_mmc_host_suspend(struct device *dev)
> >> {
> >>       struct mmc_host *mmc = dev_get_drvdata(dev);
> >>       struct tmio_mmc_host *host = mmc_priv(mmc);
> >>
> >> You can easily change the dev_get_drvdata() to platform_get_drvdata(),
> >> see include/linux/platform_device.h
> >
> > Thanks, I'm happy to make that change if you think it is worth it.
> > (I will need to re-test on AG5, which I could do this afternoon
> >  if it is free)
> 
> Hm, perhaps it can be done with incremental patches in the future?
> 
> I think it's good to be consistent and use the same argument passing
> style as other callbacks, but at the same time I'm not 100% sure if
> passing a platform data pointer is the best approach. It probably made
> sense with the old tmio_mmc driver that only hooked up to MFD, but I'm
> not sure if that's the case anymore. I'm sure there is room for plenty
> of cleanups - but exactly what to do I don't know. =)
> 
> At least passing a struct tmio_mmc_host * requires little conversion
> which should add minimal overhead.

Ok, lets stick with what we have for now.
Its a fairly trivial change to update the arguments later
if that is wanted. Testing is slightly less trivial
due to availability of hardware, but not a major problem.

Can you Acked-by, or Reviewed-by the patches in this series if
you are now happy with them?

> >> I guess a similar conversion can be done in tmio_mmc_enable_dma() to
> >> move from writew() to sd_ctrl_write16()?
> >
> > Are you proposing changing tmio_mmc_enable_dma() to take
> > a struct platform_device * as its first argument?
> 
> No, not at all. I just recall someone pointing out that
> tmio_mmc_enable_dma() skipped the tmio_mmc specific I/O routines and
> used writew() directly. I suspected the reason behind this was the
> difficulty of converting between different pointer types, but that may
> not be true.

I was probably the person who pointed that out to you.
I'm unsure of the reason, but at least in its current form
it appears not to be related to the parameters involved.

> > tmio_mmc_enable_dma() is already altered in one of the
> > patches in this series to use sd_ctrl_write16() without
> > altering the arguments taht tmio_mmc_enable_dma() takes.
> 
> Ok, that's good.
> 
> > static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
> > {
> > #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> >        /* Switch DMA mode on or off - SuperH specific? */
> >        sd_ctrl_write16(host, enable ? 2 : 0, CTL_DMA_ENABLE);
> > #endif
> > }
> 
> Hm, perhaps it's my mail setup that's the issue, but the version of
> "[PATCH 1/5] mmc: tmio: name 0xd8 as CTL_DMA_ENABLE" that I'm looking
> at is still using writew().

The writew() -> sd_ctrl_write16() change is made by the following patch
in the series, "[PATCH 2/5] mmc: tmio: Share register access functions".

The last hunk looks like this:

diff --git a/drivers/mmc/host/tmio_mmc_dma.c
b/drivers/mmc/host/tmio_mmc_dma.c
index 9c4da66..f24a029 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -26,7 +26,7 @@ static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 {
 #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
 	/* Switch DMA mode on or off - SuperH specific? */
-	writew(enable ? 2 : 0, host->ctl + (CTL_DMA_ENABLE << host->bus_shift));
+	sd_ctrl_write16(host, enable ? 2 : 0, CTL_DMA_ENABLE);
 #endif
 }


