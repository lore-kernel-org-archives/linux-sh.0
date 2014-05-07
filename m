From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 07 May 2014 09:01:32 +0000
Subject: Re: [PATCH 2/6] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <CAMuHMdX+a7re+xL2ed78Bk6FOQk4XBCnJeiGyWQJK=9=h40qdg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399386233-11928-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1399386233-11928-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tue, May 6, 2014 at 4:23 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> +struct div4_clk {
> +       const char *name;
> +       const char *parent;

parent is unused (but see below).

> +       unsigned int reg;
> +       unsigned int shift;
> +       unsigned int mask;
> +       int flags;

mask and flags are unused.

> +};
> +
> +static struct div4_clk div4_clks[] = {
> +       { "zg", "pll0", CPG_FRQCRA, 16,  0xd7f, CLK_ENABLE_ON_INIT },
> +       { "m3", "pll1", CPG_FRQCRA, 12, 0x1dff, CLK_ENABLE_ON_INIT },
> +       { "b",  "pll1", CPG_FRQCRA,  8,  0xdff, CLK_ENABLE_ON_INIT },
> +       { "m1", "pll1", CPG_FRQCRA,  4, 0x1dff, 0 },
> +       { "m2", "pll1", CPG_FRQCRA,  0, 0x1dff, 0 },
> +       { "z",  "pll0", CPG_FRQCRB, 24,  0x97f, 0 },
> +       { "zx", "pll1", CPG_FRQCRB, 12,  0xdff, 0 },
> +       { "hp", "pll1", CPG_FRQCRB,  4,  0xdff, 0 },

parents of zg and z are pll0...

> +       { NULL, 0, 0, 0, 0 },
> +};

> +               struct div4_clk *c;
> +               for (c = div4_clks; c->name; c++) {
> +                       if (!strcmp(name, c->name)) {
> +                               if (!strcmp(name, "zg"))
> +                                       parent_name = "pll0";

... parent of zg is pll0...

> +                               else
> +                                       parent_name = "pll1";

... while parent of z is pll1?

According to clock-sh73a0.c and the AG5 docs, both have pll0 as parent.

But why not use "parent_name = c->parent;"?

> +                               table = div4_div_table;
> +                               reg = c->reg;
> +                               shift = c->shift;
> +                               break;
> +                       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
