From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 12:02:06 +0000
Subject: Re: [PATCH v3 02/09] ARM: shmobile: Add APMU DT support via Enable method
Message-Id: <CAMuHMdUYNRuPnm=U3S1XTLKwQ5XMOBj9_r5YoEZ1iem25PhNyg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917063240.26016.93772.sendpatchset@little-apple>
	<20150917063300.26016.23728.sendpatchset@little-apple>
In-Reply-To: <20150917063300.26016.23728.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>

Hi Magnus,

On Thu, Sep 17, 2015 at 8:33 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ work/arch/arm/mach-shmobile/platsmp-apmu.c  2015-09-16 20:46:23.400513000 +0900

> +static void __init shmobile_smp_apmu_prepare_cpus_dt(unsigned int max_cpus)
> +{
> +       shmobile_smp_apmu_setup_boot();
> +       apmu_parse_dt(apmu_init_cpu);
> +       rcar_gen2_pm_init();
> +}

The non-DT code in arch/arm/mach-shmobile/smp-r8a7790.c has two calls to
rcar_sysc_power_up() here, cfr.:

        static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
        {
               /* let APMU code install data related to shmobile_boot_vector */
               shmobile_smp_apmu_prepare_cpus(max_cpus,
                                              r8a7790_apmu_config,
                                              ARRAY_SIZE(r8a7790_apmu_config));

                /* turn on power to SCU */
                rcar_gen2_pm_init();
==>            rcar_sysc_power_up(&r8a7790_ca15_scu);
==>            rcar_sysc_power_up(&r8a7790_ca7_scu);
        }

The non-DT code in arch/arm/mach-shmobile/smp-r8a7791.c does not have such
a call for its CA15 cluster.

Does that mean they're not needed on Gen2 in general, and that they can be
removed? I'd be happy to hear a confirming answer, as it's one less
dependency on SYSC PM Domains in early SMP code ;-)

Ah, this is because r8a7790 can boot from either CA15 or CA7, and only the
SCU for the boot CPU is powered up (r8a7791 has only one cluster/SCU, so it's
always the one with the boot CPU)?

Note that on r8a7779 we're also stuck with this dependency, as r8a7779 uses
SYSC instead of APMU for secondary core control.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
