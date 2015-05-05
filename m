From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 May 2015 09:36:41 +0000
Subject: Re: [PATCH v2 10/15] ARM: shmobile: r8a7793: add SMP support
Message-Id: <CAMuHMdUcaEiSMT0-nrUy-95_cSgW-qTdknic-nMHYh5A6zFSOA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-11-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-11-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 30, 2015 at 4:23 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Enables SMP support, similar to other R-Car Gen2 SoCs.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [uli: moved reset handling to PM, minor adjustments]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-r8a7793.c

> +static void __init r8a7793_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +       void __iomem *p;
> +       u32 val;
> +
> +       /* let APMU code install data related to shmobile_boot_vector */
> +       shmobile_smp_apmu_prepare_cpus(max_cpus,
> +                                      r8a7793_apmu_config,
> +                                      ARRAY_SIZE(r8a7793_apmu_config));
> +
> +       /* setup for debug mode */
> +       if (rcar_gen2_read_mode_pins() & MD(21)) {
> +               p = ioremap_nocache(APMU, 0x2000);
> +               val = readl_relaxed(p + CA15DBGRCR);
> +               writel_relaxed((val | 0x01f80000), p + CA15DBGRCR);
> +               iounmap(p);
> +       }

No call to rcar_gen2_pm_init()?

> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
