From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 30 Jul 2013 09:21:54 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7740: Add TPU clock entry for DT platforms
Message-Id: <16180943.d6lLygNrCS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1374792660-15893-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1374792660-15893-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tuesday 30 July 2013 11:26:22 Simon Horman wrote:
> On Fri, Jul 26, 2013 at 12:50:59AM +0200, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/mach-shmobile/clock-r8a7740.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c
> > b/arch/arm/mach-shmobile/clock-r8a7740.c index f4265e5..c826bca 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> > @@ -597,6 +597,7 @@ static struct clk_lookup lookups[] = {
> > 
> >  	CLKDEV_DEV_ID("r8a7740-gether",		&mstp_clks[MSTP309]),
> >  	CLKDEV_DEV_ID("e9a00000.sh-eth",	&mstp_clks[MSTP309]),
> >  	CLKDEV_DEV_ID("renesas-tpu-pwm",	&mstp_clks[MSTP304]),
> 
> In my tree I seem to have "renesas_tpu_pwm" instead of "renesas-tpu-pwm".
> Which is correct?

The correct one is "renesas-tpu-pwm" (http://gitorious.org/linux-pwm/linux-pwm/blobs/for-next/drivers/pwm/pwm-renesas-tpu.c#line464).

> > +	CLKDEV_DEV_ID("e6600000.pwm",		&mstp_clks[MSTP304]),
> > 
> >  	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
> >  	CLKDEV_DEV_ID("e6870000.sdhi",          &mstp_clks[MSTP415]),

-- 
Regards,

Laurent Pinchart

