From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 May 2015 09:07:20 +0000
Subject: Re: [PATCH v2 01/15] pinctrl: sh-pfc: Add r8a7793 PFC support part 1: pinmux data
Message-Id: <CAMuHMdU=wYHzjKW6Oe27wOvA_6qQBGkwtDmT+M9d2mwsAriZvg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Thu, Apr 30, 2015 at 4:18 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Part of PFC support for R-Car M2-N (r8a7793) that defines the pinmux
> data.

As this patch is difficult to quote, I'm just summarizing my comments:
  - Other R-Car Gen2 variants use "MLB_CLK" instead of "MLB_CK",
  - Compared to M2-W, CAN0/1, HSCIF2_D, and MLB+ are missing,
    but they do exist on M2-N,
  - Compared to M2-W, SSP is added, but it does exist on M2-W.

After compensating for that, pfc-r8a7793.c is identical to pfc-r8a7791.c.
So I think we should use a single file for both, or at least share (most of )
the data structures (sh_pfc_soc_info contains the SoC name, so it can't
be shared).

BTW, it's my understanding M2-W and M2-N are identical, except for the
wide/double vs. narrow/single memory channels, which doesn't impact
configurable pins. Please correct me if I'm wrong.
Are there other differences?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
