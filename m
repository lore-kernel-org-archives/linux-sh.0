From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Jan 2016 08:59:46 +0000
Subject: Re: [RFC] clk: shmobile: r8a7795: Add SD divider support
Message-Id: <CAMuHMdVx-ZhhYxCQmvY5cvtMz0x31R7UV5YDgMyKg==SVevMoA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
In-Reply-To: <1453465586-12807-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Dirk,

On Fri, Jan 22, 2016 at 1:26 PM, Dirk Behme <dirk.behme@de.bosch.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds SD[0..3] clock divider support for R-Car Gen3 SoC.
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
> Notes:
>
> * This is based on https://git.kernel.org/cgit/linux/kernel/git/horms/ren=
esas-bsp.git/commit/drivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0.=
x&id=CD10385afc15cef6bfbaea4aa5da41193b24fe82
>
> * This is compile tested *only*. The intention is to get some feedback
>   if this is the way we want to go.

I didn't look into all details, but in general this is what I intended.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
