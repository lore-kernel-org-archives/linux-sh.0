From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Mon, 03 Nov 2014 16:00:55 +0000
Subject: Re: [PATCH v4] clk: shmobile: div6: support selectable-input clocks
Message-Id: <CAO3366y98LcYGUCPXUvAKAZ28aPfCej47sUfYV-CUkJqsurxUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409238671-30452-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<20140828160528.GN14650@leverpostej>
	<1780299.8YZEnbE9lj@avalon>
In-Reply-To: <1780299.8YZEnbE9lj@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "horms@verge.net.au" <horms@verge.net.au>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "mturquette@linaro.org" <mturquette@linaro.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Fri, Aug 29, 2014 at 1:58 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
[...]
> We could thus extend the DIV6 clocks with clock source selection using the
> following layout
>
> Bits     Name           Function
> -----------------------------------------------------------------------------
> 8        CKSTP    Clock Stop
> 7-6      EXSRC    Source Selection
> 5-0      DIV      Division Ratio
>
> The clocks property would be a list of one, two, three or four clock
> references, mapping to the 00, 01, 10 and 11 values of the EXSRC field. Empty
> references (just a 0 value) would be used to denote invalid values of the
> EXSRC field.
>
> A new compatible string would then be added for the VCLK clocks with the
> following layout
>
> Bits     Name           Function
> -----------------------------------------------------------------------------
> 14-12    EXSRC    Source Selection (VCLK[123] clocks)
> 8        CKSTP    Clock Stop
> 7-6      PDIV     PLL Division Ratio (VCLK3 clock)
> 5-0      DIV      Division Ratio

I think even a new compatible string would not be necessary, given
that all such clocks have more than four parents, which cannot be the
case for clocks with two EXSRC bits.

> The clocks property would be handled as for the common DIV6 clocks, and we
> would need to define a way to describe the valid values of the PDIV field. As
> far as I can see, the PDIV values are identical for all VCLK clocks when
> implemented (00 -> 1/1, 01 -> 1/2, 10 -> Reserved, 11 -> 1/4), so a single
> renesas,has-pdiv property should be enough.

Sounds reasonable to me.

I'll send a patch.

CU
Uli
