From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Oct 2015 08:12:12 +0000
Subject: Re: [PATCH/RFC 1/6] boot-mode-reg: Add core
Message-Id: <CAMuHMdUq5-auy_=QL=n=Q+G-FMLDb63_dLRBEpqG+Zjo1AxamA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Oct 23, 2015 at 4:11 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> I had envisioned the set operation a bit differently, but that doesn't mean
> your proposal is bad. Just for the record, I was thinking of adding a macro
> similar to CLK_OF_DECLARE() to declare possible boot mode providers. The get
> operation would then walk through the list the first time it's called and try
> to get the boot mode from the provider(s) compatible with the running DT. The
> value would then be cached internally and returned on subsequent calls.

You may have gotten a different impressions from the cpg/mssr thread, but
I don't like these *_OF_DECLARE() statements at all. It's one more ordering
hack, we already had too many of.

As this is supposed to be a generic solution, what if on some SoC the hardware
block providing the mode register has a dependency like a clock or PM domain
or regulator?

At least syscon_regmap_lookup_by_phandle() (which I used for my
"renesas,modemr" proposal in the CPG driver) will cause the syscon node to
be probed if it doesn't exist yet. And a future generic solution to solve
the phandle dependency issues should do that, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
