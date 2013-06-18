From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 18 Jun 2013 12:31:58 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: Use devm_* managed helpers
Message-Id: <2566074.m8COktZgTy@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1371553171-23530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAK9yfHwq_OC6s5Lvh6j5RP5xCTzgkWxFLrUq7_5i_7gPfCDTXQ@mail.gmail.com>
In-Reply-To: <CAK9yfHwq_OC6s5Lvh6j5RP5xCTzgkWxFLrUq7_5i_7gPfCDTXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>

Hi Sachin,

On Tuesday 18 June 2013 17:13:37 Sachin Kamat wrote:
> On 18 June 2013 16:29, Laurent Pinchart wrote:
> > This simplifies the main error path by getting rid of it.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/clocksource/sh_cmt.c | 40 ++++++++++++++-------------------------
> >  1 file changed, 14 insertions(+), 26 deletions(-)
> > 
> > The patch is based on top of renesas-next-20130618 plus Magnus'
> > "clocksource: sh_cmt: 32-bit control register support" patch.
> > 
> > diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
> > index 0965e98..7001e4d 100644
> > --- a/drivers/clocksource/sh_cmt.c
> > +++ b/drivers/clocksource/sh_cmt.c

[snip]

> > @@ -703,23 +701,23 @@ static int sh_cmt_setup(struct sh_cmt_priv *p,
> > struct platform_device *pdev)> 
> >         irq = platform_get_irq(p->pdev, 0);
> >         if (irq < 0) {
> >                 dev_err(&p->pdev->dev, "failed to get irq\n");
> > -               goto err0;
> > +               return -ENXIO;
> >         }
> >         
> >         /* map memory, let mapbase point to our channel */
> > -       p->mapbase = ioremap_nocache(res->start, resource_size(res));
> > +       p->mapbase = devm_ioremap_resource(&pdev->dev, res);
> >         if (p->mapbase = NULL) {
> 
> You should check for  IS_ERR (p->mapbase) and return PTR_ERR(p->mapbase)
> 
> >                 dev_err(&p->pdev->dev, "failed to remap I/O memory\n");
> 
> This error message is not required as devm_ioremap_resource prints its own.

Oops, my bad. I'll fix that and resubmit.

-- 
Regards,

Laurent Pinchart

