From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 13 May 2014 21:50:31 +0000
Subject: Re: [PATCH 00/03] pinctrl: sh-pfc: Extend Multiplatform Support
Message-Id: <4432340.lxWPtIrT5s@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20140507231748.29661.46207.sendpatchset@w520>
In-Reply-To: <20140507231748.29661.46207.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 14 May 2014 06:42:48 Simon Horman wrote:
> On Tue, May 13, 2014 at 01:24:09PM +0200, Laurent Pinchart wrote:
> > Hi Magnus,
> > 
> > Thank you for the patches.
> > 
> > On Thursday 08 May 2014 08:17:48 Magnus Damm wrote:
> > > pinctrl: sh-pfc: Extend Multiplatform Support
> > > 
> > > [PATCH 01/03] pinctrl: sh-pfc: r8a7740: Allow Multiplatform Build
> > > [PATCH 02/03] pinctrl: sh-pfc: sh73a0: Allow Multiplatform Build
> > > [PATCH 03/03] pinctrl: sh-pfc: r8a73a4: Allow Multiplatform Build
> > > 
> > > These patches enable Multiplatform support for r8a7740, sh73a0 and
> > > r8a73a4.
> > > 
> > > The legacy case is still kept around, so the mach-header is still needed
> > > to allow static GPIO-IRQ assignment. In case of DT the GPIO IRQs are
> > > already provided via DT properties, so we can simply #ifdef out the
> > > static IRQ tables in case of Multiplatform build. Not pretty but it
> > > works.
> > 
> > Well, it builds, but does it really work ? If I'm not mistaken this patch
> > set essentially disables gpio_to_irq support for the above three SoCs as
> > the gpio_pin_to_irq() function (drivers/pinctrl/sh-pfc/gpio.c) will
> > immediately return -ENOSYS due to pfc->info->gpio_irq_size being 0.
> > Worse, the sh_pfc_register_gpiochip() function will fail with an error
> > due to
> >
> >         if (pfc->num_irqs && pfc->num_irqs != pfc->info->gpio_irq_size) {
> >         
> >                 dev_err(pfc->dev, "invalid number of IRQ resources\n");
> >                 return -EINVAL;
> >         
> >         }
> > 
> > with num_irqs being non-zero and gpio_irq_size being 0.
> > 
> > Am I missing something, or is this series completely untested ? :-)
> > 
> > I'll send another (also untested, as I have no Armadillo board anymore
> > ;-)) patch set shortly with a proposed fix.
> 
> I'm happy to provide testing, if you let me know what to look for.

Making sure that the GPIO keys still work on Armadillo with a multiplatform 
kernel should be enough.

> I'm also happy to provide remote access to a board if you think this would
> be useful in future (its a bit of work for me to set up).

It might be useful in the future, but given that the test is pretty simple 
here, it would probably be easier if you could perform it yourself.

-- 
Regards,

Laurent Pinchart

