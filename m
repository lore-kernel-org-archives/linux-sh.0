From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Aug 2015 09:44:33 +0000
Subject: Re: [PATCH 0/7] Bock-W legacy excision
Message-Id: <CAMuHMdXT1Ag+HajrOG3uE8nzq478fTxUSMCKjjfSZo37kTgi=w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439560268-4935-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1439560268-4935-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Uli,

On Fri, Aug 14, 2015 at 3:51 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> This eliminates the last shmobile legacy platform, Bock-W, and with it a
> number of other things that have thus become obsolete.

Thanks!

> Ulrich Hecht (7):
>   ARM: shmobile: bockw: remove legacy board file and config
>   ARM: shmobile: r8a7778: remove obsolete setup code
>   ARM: shmobile: Kconfig: remove obsolete option ARCH_R8A7778
>   ARM: shmobile: r8a7778: remove legacy clock implementation
>   ARM: shmobile: remove ARCH_SHMOBILE_LEGACY option
>   ARM: shmobile: bockw: remove legacy defconfig
>   MAINTAINERS: remove references to dropped marzen and bockw defconfigs

You forgot to remove
  - the small ARCH_SHMOBILE_LEGACY hunk with r8a7778-bockw.dtb
    in arch/arm/boot/dts/Makefile,
  - the ARCH_SHMOBILE section with the now unused Kconfig symbol
    SHMOBILE_TIMER_HZ in arch/arm/mach-shmobile/Kconfig.

With those fixed:
Acked-by: by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
