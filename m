From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 May 2015 17:57:06 +0000
Subject: Re: [PATCH v3 11/11] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <CAMuHMdVRgEP3+g93=PUGrtL2iwdeccVgPQ7RSqYcT1F6LWBa9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Thu, May 21, 2015 at 12:48 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Regulator setup seems identical to Koelsch.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Have you tested this?

You forgot to update the Makefile with:

+obj-$(CONFIG_ARCH_R8A7793)     += regulator-quirk-rcar-gen2.o

(and add "select I2C" to "config ARCH_R8A7793").

If enabled, it will tell you if it did anything.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
