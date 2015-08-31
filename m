From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 09:08:33 +0000
Subject: Re: [PATCH v8 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
Message-Id: <CAMuHMdVVdwwQ5icRepryT95809x6+tRDOxbUX929t1NHp8XiWw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062930.24004.93722.sendpatchset@little-apple>
In-Reply-To: <20150831062930.24004.93722.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, Aug 31, 2015 at 8:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Add all clocks generated from PLL1 by the CPG common divider block.
> This includes s3d4, which was modelled as a direct child from pll1
> before.

The last sentence is no longer needed due to the folding in mentioned below.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  Based on:
>   [PATCH 3/3] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
>
>  Changes: (Magnus Damm <damm+renesas@opensource.se>)
>  - Folded in s3d4_clk
>  - Reordered to apply without SCIF bits

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
