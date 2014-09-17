From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Sep 2014 14:48:02 +0000
Subject: Re: [PATCH 0/3] Remove Koelsch board files
Message-Id: <CAMuHMdVCwA7pK+YPBx9obXDRnXSi6_HRxK_JnwH-DjZUHcdWeg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410964685-12143-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410964685-12143-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Sep 17, 2014 at 4:38 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> This patch set (also know as "look at the diffstat and fall in love") removes
> both the legacy and reference Koelsch board files, now that the Koelsch board
> is supported by the r8a7791 generic DT platform.

Great, thanks!

>  arch/arm/configs/koelsch_defconfig               | 113 -----
>  arch/arm/configs/shmobile_defconfig              |   1 -
>  arch/arm/mach-shmobile/Kconfig                   |  19 -
>  arch/arm/mach-shmobile/Makefile                  |   3 -
>  arch/arm/mach-shmobile/Makefile.boot             |   1 -
>  arch/arm/mach-shmobile/board-koelsch-reference.c |  44 --
>  arch/arm/mach-shmobile/board-koelsch.c           | 530 -----------------------
>  arch/arm/mach-shmobile/clock-r8a7791.c           | 342 ---------------
>  arch/arm/mach-shmobile/r8a7791.h                 |   3 -
>  arch/arm/mach-shmobile/setup-r8a7791.c           | 181 +-------
>  10 files changed, 1 insertion(+), 1236 deletions(-)

Please make it 11 files changed, 1 insertion(+), 1237 deletions(-),
by removing one r8a7791-koelsch.dtb line from arch/arm/boot/dts/Makefile...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
