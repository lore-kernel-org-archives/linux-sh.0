From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2015 10:46:34 +0000
Subject: Re: [PATCH 06/13] ARM: shmobile: mackerel: Remove defconfig
Message-Id: <CAMuHMdW7WF00LHheNAkQZQizrO0MH91EScuuR1_hwebRqznXrA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150121045357.7648.6160.sendpatchset@little-apple>
In-Reply-To: <20150121045357.7648.6160.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

On Wed, Jan 21, 2015 at 5:53 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Remove the defconfig for the no longer supported mackerel board.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
>
>  arch/arm/configs/mackerel_defconfig |  157 -----------------------------------
>  1 file changed, 157 deletions(-)

You forgot the reference to mackerel_defconfig in MAINTAINERS.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
