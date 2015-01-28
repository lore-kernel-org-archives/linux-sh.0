From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 28 Jan 2015 09:14:53 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: Correct SDHI clock base address, labels and output-names
Message-Id: <CAMuHMdWzvwmX8uN+Do-1vZiSeqknLdgmv060GCvbZd1=x4YnXA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422406422-671-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1422406422-671-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 28, 2015 at 1:53 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> * Correct base address of SD3 div6 clk.
> * Update div6 clock node labels
>   There appears to have been some inconsistency and confusion here as on
>   the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
>   the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.
>
> This has no run-time affect as the clock nodes are not currently used.
>
> Fixes: 8e181633e6ca96049 ("ARM: shmobile: r8a7794: Add SDHI clocks to device tree")
> Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
