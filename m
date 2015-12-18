From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 18 Dec 2015 11:02:42 +0000
Subject: Re: [PATCH 1/2] arm64: dts: r8a7795: Add Cortex-A53 CPU cores
Message-Id: <CAMuHMdVVL9T6U8npb5kOLdP3PmS6Lhx0b9O3FKgxd2HQcUedFw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
In-Reply-To: <1449904607-4060-1-git-send-email-dirk.behme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Dirk,

On Sat, Dec 12, 2015 at 8:16 AM, Dirk Behme <dirk.behme@gmail.com> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> This patch adds Cortex-A53 CPU cores to r8a7795 SoC for a total of 8
> cores (4 x Cortex-A57 + 4 x Cortex-A53).
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>

Thanks, I can confirm this works.

However, as the scheduler is not big.LITTLE aware (running processes are not
migrated automatically to the faster CA57 cores when these are idle), it makes
performance less deterministic.

Hence we would like to postpone this.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
