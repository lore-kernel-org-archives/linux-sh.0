From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Dec 2014 09:16:22 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: defconfig: cleanup by savedefconfig
Message-Id: <CAMuHMdW7uxgSRr2+RvjZO_aUg3Oc0UeW9XnQ=psCLmFXaD01hw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uio83sx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uio83sx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Dec 4, 2014 at 4:57 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> Current shmobile_defconfig is not created from savedefconfig.
> Therefore, next defconfig patch will be unreadable. this patch
> tidyup this issue by below command

Thanks a lot!

>  > make shmobile_defconfig
>  > make savedefconfig
>  > cp defconfig ${LINUX}/arch/arm/config/shmobile_defconfig

It's actually a good practice to update the defconfigs from time to time,
so people don't have such a hard time to generate updates for it.

Note that you best keep your old .config generated from shmobile_defconfig
and run "make oldconfig". That will catch cases where a "select" was
dropped from a Kconfig file. When just running "make shmobile_defconfig",
you may end up with a .config where some option is suddenly disabled
because it's no longer selected automatically.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
