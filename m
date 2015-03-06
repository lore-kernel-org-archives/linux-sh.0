From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 06 Mar 2015 11:05:24 +0000
Subject: Re: [PATCH 2/4] pinctrl: sh-pfc: Store register/field widths in u8 instead of unsigned long
Message-Id: <2354666.zjhAAbqIil@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be> <12083025.CFMfs0EISD@avalon> <CAMuHMdVYUod+rqrjmvtwqT4dbJiGtt+qQW0CbRd5j6uGFJ3=gQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVYUod+rqrjmvtwqT4dbJiGtt+qQW0CbRd5j6uGFJ3=gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

On Thursday 05 March 2015 10:19:33 Geert Uytterhoeven wrote:
> On Thu, Mar 5, 2015 at 10:03 AM, Laurent Pinchart wrote:
> >> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> >> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> >> @@ -69,9 +69,10 @@ struct pinmux_func {
> >>  };
> >>  
> >>  struct pinmux_cfg_reg {
> >> -     unsigned long reg, reg_width, field_width;
> >> +     unsigned long reg;
> > 
> > How about making reg a u32 ? It won't make a difference in practice on
> > 32-bit systems, but it would be more explicit.

You might have missed this comment.

> > We could also save space by making reg a u16 and storing the register
> > offset only instead of the full address (assuming it can always fit in 16
> > bits, which should be checked). We'll also need to support 64-bit systems
> > at some point, and making reg a u64 would increase space waste.
> 
> That would be more intrusive (and definitely needs to be in a separate
> patch), as reg is used here to store a physical register address, for
> conversion between physical and virtual addresses. I didn't want to go that
> far yet.
> 
> u16 would indeed be nice, as it means reg, reg_width, and field_width
> would fit in one 32-bit word, which I hadn't realized. That means we can
> reduce each entry by 2 words instead of 1.
> 
> For 64-bit that would still be suboptimal, as pointers are aligned to 8
> bytes, leading to gaps.
> Perhaps we do want __packed here, too? I don't think the performance drop of
> doing some unaligned accesses would be significant. This isn't a hot path.

-- 
Regards,

Laurent Pinchart

