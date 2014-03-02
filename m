From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 02 Mar 2014 20:35:28 +0000
Subject: Re: [PATCH v2 21/40] clocksource: sh_cmt: Request IRQ for clock event device only
Message-Id: <3258448.OkuRkXDiH4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393603090-23144-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393603090-23144-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Saturday 01 March 2014 18:46:46 Geert Uytterhoeven wrote:
> On Fri, Feb 28, 2014 at 4:57 PM, Laurent Pinchart wrote:
> > --- a/drivers/clocksource/sh_cmt.c
> > +++ b/drivers/clocksource/sh_cmt.c
> > @@ -789,6 +789,8 @@ static void sh_cmt_register_clockevent(struct
> > sh_cmt_channel *ch,> 
> >                                        const char *name)
> >  {
> >         struct clock_event_device *ced = &ch->ced;
> > +       int irq;
> > +       int ret;
> > 
> >         ced->name = name;
> >         ced->features = CLOCK_EVT_FEAT_PERIODIC;
> > @@ -803,6 +805,20 @@ static void sh_cmt_register_clockevent(struct
> > sh_cmt_channel *ch,> 
> >         dev_info(&ch->cmt->pdev->dev, "ch%u: used for clock events\n",
> >                  ch->index);
> >         
> >         clockevents_register_device(ced);
> > +
> > +       irq = platform_get_irq(ch->cmt->pdev, ch->cmt->legacy ? 0 :
> > ch->index);
> > +       if (irq < 0) {
> > +               dev_err(&ch->cmt->pdev->dev, "ch%u: failed to get irq\n",
> > +                       ch->index);
> > +               return;
> 
> So the failure is no longer passed upstream, as sh_cmt_register_clockevent()
> returns void. Can you please change it to return the error code?

Sure, I'll fix that for v3.

> Interestingly, its caller (sh_cmt_register()) does return an error code,
> but currently this is hardcoded to zero.
> And the caller of sh_cmt_register() already checks for an error code.
> 
> > +       }
> > +
> > +       ret = request_irq(irq, sh_cmt_interrupt,
> > +                         IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
> > +                         dev_name(&ch->cmt->pdev->dev), ch);
> > +       if (ret)
> > +               dev_err(&ch->cmt->pdev->dev, "ch%u: failed to request irq
> > %d\n", +                       ch->index, irq);
> > 
> >  }

-- 
Regards,

Laurent Pinchart

