From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Sep 2015 06:57:06 +0000
Subject: Re: [PATCH][RFC] arm64: renesas: r8a7795 dtsi: Update common divider clocks
Message-Id: <CAMuHMdUDKYYAh+AZieoj__ahPpfcPPNJU1AJ9=C5TAVU3nu8tw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150908044342.21900.84407.sendpatchset@little-apple>
In-Reply-To: <20150908044342.21900.84407.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tue, Sep 8, 2015 at 6:43 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Update the r8a7795 CPG DTS to include pll1_div2. In older r8a7795 CPG
> CCF driver implementations the output of PLL1 was divided by two.
>
> To support r8a7795 clocks like RPCSRC the PLL1 has now been converted
> to not divide by two in the V7 CPG series, so when that series is used
> we have to divide by two using a fixed divider outside the CPG.

Thanks!

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
