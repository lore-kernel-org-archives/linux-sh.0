From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 May 2015 12:55:45 +0000
Subject: Re: [PATCH v3 04/11] ARM: shmobile: r8a7793: add SMP support
Message-Id: <CAMuHMdUqe3PPuRtaf5bbqRMOfvkQ0-+aXeHqqZvbZUW7zBirfQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205293-9488-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205293-9488-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Thu, May 21, 2015 at 12:48 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Enables SMP support, similar to other R-Car Gen2 SoCs.

> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-r8a7793.c

> +static struct rcar_apmu_config r8a7793_apmu_config[] = {
> +       {
> +               .iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
> +               .cpus = { 0, 1 },
> +       },
> +};

This is different from r8a7791.

Last time you replied:

> > The resource is larger on the r8a7791 because it has more cores.

but that's not correct: both r8a7791 and r8a7793 have 2 CA15 cores.

The number of cores doesn't matter:
  - CA7 registers are at 0xe6151000-0xe6151187 .
  - CA15 registers are at 0x6e152000-0xe6152187.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
