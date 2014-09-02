From: Mike Turquette <mturquette@linaro.org>
Date: Tue, 02 Sep 2014 00:23:29 +0000
Subject: Re: [PATCH v4] clk: shmobile: div6: support selectable-input clocks
Message-Id: <20140902002329.5251.82127@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1409238671-30452-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1409238671-30452-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ulrich Hecht <ulrich.hecht@gmail.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Quoting Ulrich Hecht (2014-08-28 08:11:11)
> From: Ulrich Hecht <ulrich.hecht@gmail.com>
> 
> Support for setting the parent at initialization time based on the current
> hardware configuration in DIV6 clocks with selectable parents as found in
> the r8a73a4, r8a7740, sh73a0, and other SoCs.

<snip>

> -       parent_name = of_clk_get_parent_name(np, 0);
> +       if (!of_property_read_u32(np, "renesas,src-shift", &src_shift)) {
> +               if (!of_property_read_u32(np, "renesas,src-width",
> +                                       &src_width)) {
> +                       unsigned int parent_idx > +                               (clk_readl(clock->reg) >> src_shift) &
> +                               (BIT(src_width) - 1);
> +                       parent_name = of_clk_get_parent_name(np, parent_idx);

Can the clock source be selected at run-time? Is there a use case for
this?

If so it is probably better to actually model these clocks as
multiplexers with the corresponding .get_parent and .set_parent
callbacks.

Regards,
Mike
