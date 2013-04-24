From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 24 Apr 2013 21:20:42 +0000
Subject: Re: [PATCH 2/4] sh-pfc: sh73a0: Add VCCQ MC0 regulator
Message-Id: <1590111.1UoTytYiZa@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1366672585-9098-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1366672585-9098-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

Thanks for the review.

On Wednesday 24 April 2013 14:36:10 Linus Walleij wrote:
> On Tue, Apr 23, 2013 at 1:16 AM, Laurent Pinchart wrote:
> > The sh73a0 has an internal power gate on the VCCQ power supply for the
> > SDHI0 device that is controlled (for some strange reason) by a bit in a
> > PFC register.
> > 
> > Export a regulator to control the SDHI0 VCCQ power supply.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> I need Mark Browns consent+ACK on this but I'm OK with it under the special
> circumstances.

I'm not very fond of this either, but given the circumstances there's few 
other options. The best one would be to fix the hardware design(ers) :-)

> However pls update the commit message with some info that the register
> bits are used by pin control too and thus there is no way to achieve
> an atomic writel/readl sequence unless this is under the pinctrl umbrella
> so you can take &pfc->lock.

Done.

> > +static void __sh73a0_vccq_mc0_enable(struct regulator_dev *reg, bool
> > enable)
>
> Skip the __ and the confusing name "_enable" for a function that
> does both enable and disable.
> 
> Call it sh73a0_vccq_mc0_endisable is my suggestion.

That's a weird name, but I can live with that.

I'll submit a v2 with the two changes.

> Apart from that I'm happy with it if Mark is.

-- 
Regards,

Laurent Pinchart

