From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Jan 2016 08:01:38 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <CAMuHMdXWpeowoPbk4iJ=B_GbaGovVJ5PCQzto4rWC6OYHqbcVw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tue, Jan 19, 2016 at 1:30 AM, Simon Horman <horms@verge.net.au> wrote:
> In rcar_gen2_timer_init() I think we can replace the use of boot mode pins
> with use of extal frequency from DT, as suggested earlier from Laurent.

Indeed. And it's really the extal frequency we need there, not the mode pin
configuration.

> An implication of that is that we could infer the boot mode settings
> from the extal frequency and then use that in rcar_gen2_cpg_clocks_init().
> Though I'm not sure how we would transmit the information from
> rcar_gen2_timer_init() to rcar_gen2_cpg_clocks_init().

Deriving the mode pin configuration from the extal frequency sounds backwards
to me. What if a non-standard crystal is used, like on Salvator-X?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
