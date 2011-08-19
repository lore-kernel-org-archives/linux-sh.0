From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Aug 2011 03:30:49 +0000
Subject: Re: [PATCH 2/4] mmc: tmio: Provide separate interrupt handlers
Message-Id: <20110819033043.GB12106@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1313716221-20136-1-git-send-email-horms@verge.net.au>
 <1313716221-20136-3-git-send-email-horms@verge.net.au>
 <CANqRtoTprsGo4yAMtfLGXjd+KQffM5f9rNnXXMFWxg-aL3nyBA@mail.gmail.com>
In-Reply-To: <CANqRtoTprsGo4yAMtfLGXjd+KQffM5f9rNnXXMFWxg-aL3nyBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Fri, Aug 19, 2011 at 12:09:50PM +0900, Magnus Damm wrote:
> On Fri, Aug 19, 2011 at 10:10 AM, Simon Horman <horms@verge.net.au> wrote:
> > Provide separate interrupt handlers which may be used by platforms where
> > SDHI has three interrupt sources.
> >
> > This patch also removes the commented-out handling of CRC and other errors.
> >
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> >
> > ---
> 
> > +irqreturn_t tmio_mmc_irq(int irq, void *devid)
> > +{
> > +       struct tmio_mmc_host *host = devid;
> > +       unsigned int ireg, status;
> > +
> > +       pr_debug("MMC IRQ begin\n");
> > +
> > +       tmio_mmc_card_irq_status(host, &ireg, &status);
> > +       if (__tmio_mmc_card_detect_irq(host, ireg, status))
> > +               return IRQ_HANDLED;
> > +       if (__tmio_mmc_sdcard_irq(host, ireg, status))
> > +               return IRQ_HANDLED;
> > +
> > +       tmio_mmc_sdio_irq(irq, devid);
> >
> > -out:
> >        return IRQ_HANDLED;
> >  }
> >  EXPORT_SYMBOL(tmio_mmc_irq);
> 
> Is there any particular reason for returning early in this interrupt
> handler? By returning early I mean the "if ... return IRQ_HANDLED"
> cases above.
> 
> I realize the old ISR code in the driver does just this, so if the
> goal is to stay compatible then I guess we should keep this behavior.
> >From my point of view it usually makes more sense to try to handle all
> events that may be associated with the IRQ.

My original post had the behaviour that you suggest but Guennadi
indicted that he would be much more comfortable with keeping the original
behaviour as it is know to work on a wide range of hardware.


