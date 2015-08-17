From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2015 09:44:24 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7778: enable IRLM setup via DT
Message-Id: <CAMuHMdWhm2NoW=bUA3ndxhG9a+Sdu1bvief573qvDwCdyS+fyw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439560388-5061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1439560388-5061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 14, 2015 at 3:53 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Works the same as on r8a7779.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7778.dtsi            | 3 ++-
>  drivers/irqchip/irq-renesas-intc-irqpin.c | 6 ++++--

I think this should be split in two separate patches.

For both, you can add my
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
