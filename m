From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 15 Dec 2013 13:06:31 +0000
Subject: Re: [PATCH v4 1/3] ARM: shmobile: wait for MSTP clock status to toggle, when enabling it
Message-Id: <CAMuHMdWu+W7-V6O57vaC5_ynv_H3kQ+sRQYcAcYeCSz52P1LaQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387034633-3798-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387034633-3798-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 14, 2013 at 4:23 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
>  static int sh_clk_mstp_enable(struct clk *clk)
>  {
>         sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
> +       if (clk->status_reg) {
> +               unsigned int (*read)(const void __iomem *addr);
> +               int i;
> +               void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
> +                       (phys_addr_t)clk->enable_reg + clk->mapped_reg;
> +
> +               if (clk->flags & CLK_ENABLE_REG_8BIT)
> +                       read = r8;
> +               else if (clk->flags & CLK_ENABLE_REG_16BIT)
> +                       read = r16;
> +               else
> +                       read = r32;
> +
> +               for (i = 1000;
> +                    (read(mapped_status) & (1 << clk->enable_bit)) && i;
> +                    i--)
> +                       cpu_relax();
> +               if (!i) {
> +                       pr_err("cpg: failed to enable %p[%d]\n",
> +                              clk->enable_reg, clk->enable_bit);
> +                       return -ETIMEDOUT;
> +               }

Just wondering: what's a typical value of i when leaving the loop?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
