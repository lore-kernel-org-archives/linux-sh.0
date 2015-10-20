From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2015 10:09:55 +0000
Subject: Re: [PATCH v4 2/5] [RFC] clk: shmobile: Add r8a7795 CPG Core Clock Definitions
Message-Id: <CAMuHMdX8kHcRCkmLbPt7SNC4CZnQm+B834sLdotT2PtQuzFUmA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444999760-15750-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Oct 16, 2015 at 2:49 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add all R-Car H3 CPG Core Clock Outputs defined in the datasheet.

Cfr. Table 8.2a ("List of Clocks [R-Car H3]").

> --- /dev/null
> +++ b/include/dt-bindings/clock/r8a7795-cpg-mssr.h
> @@ -0,0 +1,63 @@
> +/*
> + * Copyright (C) 2015 Renesas Electronics Corp.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +#ifndef __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__
> +#define __DT_BINDINGS_CLOCK_R8A7795_CPG_MSSR_H__
> +
> +#include <dt-bindings/clock/renesas-cpg-mssr.h>
> +
> +/* r8a7795 CPG Core Clocks */
> +#define R8A7795_CLK_Z                  0
> +#define R8A7795_CLK_Z2                 1
> +#define R8A7795_CLK_ZR                 2
> +#define R8A7795_CLK_ZG                 3
> +#define R8A7795_CLK_ZTR                        4
> +#define R8A7795_CLK_ZTRD2              5
> +#define R8A7795_CLK_ZT                 6
> +#define R8A7795_CLK_ZX                 7
> +#define R8A7795_CLK_S0D1               8
> +#define R8A7795_CLK_S0D4               9
> +#define R8A7795_CLK_S1D1               10
> +#define R8A7795_CLK_S1D2               11
> +#define R8A7795_CLK_S1D4               12
> +#define R8A7795_CLK_S2D1               13
> +#define R8A7795_CLK_S2D2               14
> +#define R8A7795_CLK_S2D4               15
> +#define R8A7795_CLK_S3D1               16
> +#define R8A7795_CLK_S3D2               17
> +#define R8A7795_CLK_S3D4               18

Please note that I deliberately left out S[0-3], as they're used as
internal clock
sources only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
