From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Nov 2014 09:04:44 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
Message-Id: <20141112090443.GY9007@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-2-git-send-email-geert+renesas@glider.be>
 <20141107052420.GA1278@katana>
 <20141112014450.GC11597@verge.net.au>
 <CAMuHMdUUspG8-dYGiO7cmuECBLpfmQAYg=B8ZpajxRXhaEUJ2A@mail.gmail.com>
In-Reply-To: <CAMuHMdUUspG8-dYGiO7cmuECBLpfmQAYg=B8ZpajxRXhaEUJ2A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Nov 12, 2014 at 09:53:27AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Nov 12, 2014 at 2:44 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Fri, Nov 07, 2014 at 06:24:21AM +0100, Wolfram Sang wrote:
> >> On Thu, Nov 06, 2014 at 12:52:06PM +0100, Geert Uytterhoeven wrote:
> >> > On sh73a0/kzm9g-legacy, probing of the i2c masters fails with:
> >> >
> >> >     i2c-sh_mobile i2c-sh_mobile.0: timing values out of range: L/H=0x208/0x1bf
> >> >     sh_mobile: probe of i2c-sh_mobile.0 failed with error -22
> >>
> >> Yay, so the warning I added found another bug \o/
> >>
> >> >
> >> > According to the datasheet, the transfer rate is derived from the HP
> >> > clock (which runs at 104 MHz) divided by two. Hence
> >> > i2c_sh_mobile_platform_data.clks_per_count should be set to two.
> >> >
> >> > Now probing succeeds, and i2c works:
> >> >
> >> >     i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz (L/H=0x104/0xe0)
> >> >
> >> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> > As this appears to be a bug fix I would like to accompany this patch with
> > some text describing when the problem was introduced and what its effects
> > are. In short a rough guide to if it should be applied to -stable. To that
> > end I prepared the following which I would appreciate your feedback on.
> >
> > * ARM: shmobile: kzm9g legacy: Set i2c clks_per_count
> >
> >   This problem appears to have been introduced when i2c shmobile support was
> >   added to the sh73a9 by b028f94b76319e1b8 ("ARM: mach-shmobile: sh73a0
> 
> sh73a0

Thanks.

> >   i2c_shmobile support.") in v2.6.37.
> >
> >   Without this fix i2c may not operate correctly on the sh73a0/kzm9g.
> 
> Thanks, that's correct.
> 
> BTW, I guess Kuribayashi-san was aware of the problem:
> 
> commit ebd5ac165f2aaefb767c53112c2010b0ff3df688
> Author: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> Date:   Wed Oct 24 19:58:10 2012 +0900
> 
>     i2c: i2c-sh_mobile: support I2C hardware block with a faster operating clock
> 
>     On newer SH-/R-Mobile SoCs, a clock supply to the I2C hardware block,
>     which is used to generate the SCL clock output, is getting faster than
>     before, while on the other hand, the SCL clock control registers, ICCH
>     and ICCL, stay unchanged in 9-bit-wide (8+1).
> 
>     On such silicons, the internal SCL clock counter gets incremented every
>     2 clocks of the operating clock.
> 
>     This patch makes it configurable through platform data.
> 
>     Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>     Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> But I couldn't find any patches on a public mailing list using the new
> clks_per_count field...

My understanding is that unfortunately Kuribayashi-san is no longer
working for Renesas. But I can try to raise this with the BSP team
if you like.
