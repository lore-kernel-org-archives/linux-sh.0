From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 02 Dec 2014 13:01:34 +0000
Subject: Re: [PATCH v3 3/6] ARM: shmobile: r8a73a4: Add CPG register bits header
Message-Id: <2234539.9ugGykYzcZ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1417509409-31638-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1417509409-31638-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday 02 December 2014 15:56:11 Sergei Shtylyov wrote:
> On 12/2/2014 3:20 PM, Laurent Pinchart wrote:
> 
> [...]
> 
> >> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> >> ---
> >> 
> >>   include/dt-bindings/clock/r8a73a4-clock.h | 62 ++++++++++++++++++++++++
> >>   1 file changed, 62 insertions(+)
> >>   create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h
> >> 
> >> diff --git a/include/dt-bindings/clock/r8a73a4-clock.h
> >> b/include/dt-bindings/clock/r8a73a4-clock.h new file mode 100644
> >> index 0000000..9a4b4c9
> >> --- /dev/null
> >> +++ b/include/dt-bindings/clock/r8a73a4-clock.h
> >> @@ -0,0 +1,62 @@
> >> +/*
> >> + * Copyright 2014 Ulrich Hecht
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + */
> >> +
> >> +#ifndef __DT_BINDINGS_CLOCK_R8A73A4_H__
> >> +#define __DT_BINDINGS_CLOCK_R8A73A4_H__
> >> +
> >> +/* CPG */
> >> +#define R8A73A4_CLK_MAIN	0
> >> +#define R8A73A4_CLK_PLL0	1
> >> +#define R8A73A4_CLK_PLL1	2
> >> +#define R8A73A4_CLK_PLL2	3
> >> +#define R8A73A4_CLK_PLL2S	4
> >> +#define R8A73A4_CLK_PLL2H	5
> >> +#define R8A73A4_CLK_Z		6
> >> +#define R8A73A4_CLK_Z2		7
> >> +#define R8A73A4_CLK_I		8
> >> +#define R8A73A4_CLK_M3		9
> >> +#define R8A73A4_CLK_B		10
> >> +#define R8A73A4_CLK_M1		11
> >> +#define R8A73A4_CLK_M2		12
> >> +#define R8A73A4_CLK_ZX		13
> >> +#define R8A73A4_CLK_ZS		14
> >> +#define R8A73A4_CLK_HP		15
> >> +
> >> +/* MSTP2 */
> >> +#define R8A73A4_CLK_DMAC	18
> >> +#define R8A73A4_CLK_SCIFB3	17
> >> +#define R8A73A4_CLK_SCIFB2	16
> >> +#define R8A73A4_CLK_SCIFB1	7
> >> +#define R8A73A4_CLK_SCIFB0	6
> >> +#define R8A73A4_CLK_SCIFA0	4
> >> +#define R8A73A4_CLK_SCIFA1	3
> >> +
> >> +/* MSTP3 */
> >> +#define R8A73A4_CLK_CMT1	29
> >> +#define R8A73A4_CLK_IIC1	23
> >> +#define R8A73A4_CLK_IIC0	18
> >> +#define R8A73A4_CLK_IIC7	17
> >> +#define R8A73A4_CLK_IIC6	16
> >> +#define R8A73A4_CLK_MMCIF0	15
> >> +#define R8A73A4_CLK_SDHI0	14
> >> +#define R8A73A4_CLK_SDHI1	13
> >> +#define R8A73A4_CLK_SDHI2	12
> >> +#define R8A73A4_CLK_MMCIF1	5
> >> +#define R8A73A4_CLK_IIC2	0
> >> +
> >> +/* MSTP4 */
> >> +#define R8A73A4_CLK_IIC3	11
> >> +#define R8A73A4_CLK_IIC4	10
> >> +#define R8A73A4_CLK_IIC5	9
> >> +
> >> +/* MSTP5 */
> >> +#define R8A73A4_CLK_THERMAL	22
> >> +#define R8A73A4_CLK_IIC8	15
> > 
> > You've sorted the MSTP clocks by increasing indices,
> > except for MSTP5. With this fixed,
> 
> Actually, only CPG clocks are sorted that way, all MSTPn clocks are sorted
> by decreasing indices. :-)

OK, that's a new one, I was looking at v2 to replied to v3 :-) Please ignore 
my comment, v3 is fine.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

