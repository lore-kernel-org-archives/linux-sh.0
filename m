From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2015 12:06:31 +0000
Subject: Re: [PATCH] ARM: shmobile: remove Makefile.boot
Message-Id: <CAMuHMdWYM6vVWzUQgR4u8cvoH6Jtq4XerYd2PbpvfUruDPi7-Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440113264-30359-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440113264-30359-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Aug 21, 2015 at 1:27 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Now that the only multiplatform boot is supported for all
> shmobile platforms Makefile.boot may be removed.
>
> This seems correct to me given:
> * Setting MACHINE to no value in arch/arm/Makefile
>   if CONFIG_ARCH_MULTIPLATFORM is set
> * Not including Makefile.boot in arch/arm/boot/Makefile
>   if MACHINE has no value
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
