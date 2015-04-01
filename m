From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 01 Apr 2015 13:31:43 +0000
Subject: Re: [RFC/PATCH] ARM: shmobile: Consolidate the smp code for R-Car Gen2
Message-Id: <CAMuHMdUTup54msyug78SZZ16oVCxMH+a6j-sLXu_PNQUob8=fg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5502A268.2030304@bp.renesas.com>
In-Reply-To: <5502A268.2030304@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Inami-san,

On Wed, Mar 25, 2015 at 6:45 AM, Gaku Inami
<gaku.inami.xw@bp.renesas.com> wrote:
> The smp code for R-Car Gen2 is scatterd in each SoC. These files
> (smp-r8a7790.c/smp-r8a7791.c) have some overlap code. This change
> consolidate the smp code for R-Car Gen2 into one.

Thanks for your patch!

> --- /dev/null
> +++ b/arch/arm/mach-shmobile/smp-rcar-gen2.c
> @@ -0,0 +1,125 @@
> +/*
> + * R-Car Generation 2 SMP support
> + *
> + * Copyright (C) 2015 Renesas Electronics Corporation
> + * Copyright (C) 2013 Magnus Damm
> + * Copyright (C) 2012-2013 Renesas Solutions Corp.
> + * Copyright (C) 2012 Takashi Yoshii <takashi.yoshii.ze@renesas.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/smp.h>
> +
> +#include <asm/cputype.h>
> +#include <asm/smp_plat.h>
> +
> +#include "common.h"
> +#include "platsmp-apmu.h"
> +#include "pm-rcar.h"
> +#include "rcar-gen2.h"
> +
> +static struct rcar_sysc_ch rcar_gen2_ca15_scu = {
> +       .chan_offs = 0x180, /* PWRSR5 .. PWRER5 */
> +       .isr_bit = 12, /* CA15-SCU */
> +};
> +
> +static struct rcar_sysc_ch rcar_gen2_ca7_scu = {
> +       .chan_offs = 0x100, /* PWRSR3 .. PWRER3 */
> +       .isr_bit = 21, /* CA7-SCU */
> +};
> +
> +static struct rcar_apmu_config r8a7790_apmu_config[] = {
> +       {
> +               .iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
> +               .cpus = { 0, 1, 2, 3 },
> +       },
> +       {
> +               .iomem = DEFINE_RES_MEM(0xe6151000, 0x188),
> +               .cpus = { 0x100, 0x0101, 0x102, 0x103 },
> +       }
> +};
> +
> +static struct rcar_apmu_config r8a7791_apmu_config[] = {
> +       {
> +               .iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
> +               .cpus = { 0, 1 },
> +       }
> +};
> +
> +static void __init rcar_gen2_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +       struct device_node *np, *cpus;
> +       bool has_a7 = false;
> +       bool has_a15 = false;
> +       u32 this_cluster;
> +       struct rcar_apmu_config *rcar_gen2_apmu_config;
> +       u32 rcar_apmu_config_size;
> +
> +       cpus = of_find_node_by_path("/cpus");
> +       if (!cpus)
> +               return;
> +
> +       for_each_child_of_node(cpus, np) {
> +               if (of_device_is_compatible(np, "arm,cortex-a15"))
> +                       has_a15 = true;
> +               else if (of_device_is_compatible(np, "arm,cortex-a7"))
> +                       has_a7 = true;
> +       }
> +
> +       if (of_machine_is_compatible("renesas,r8a7790")) {
> +               rcar_gen2_apmu_config = &r8a7790_apmu_config[0];
> +               rcar_apmu_config_size = ARRAY_SIZE(r8a7790_apmu_config);
> +       } else if (of_machine_is_compatible("renesas,r8a7791")) {
> +               rcar_gen2_apmu_config = &r8a7791_apmu_config[0];
> +               rcar_apmu_config_size = ARRAY_SIZE(r8a7791_apmu_config);
> +       }

I wonder whether we should replace the "compatible" matching by reading
the Product Register (PRR, iomem 0xff000044), looking at bits 22-25 and 27-30
to check for the presence of CA7 and CA15 CPU cores, and fill in the
rcar_apmu_config tables based on that. That way it'll work automatically for
all members of the R-Car Gen2 family.

> +       /* let APMU code install data related to shmobile_boot_vector */
> +       shmobile_smp_apmu_prepare_cpus(max_cpus,
> +                                      rcar_gen2_apmu_config,
> +                                      rcar_apmu_config_size);
> +
> +       rcar_gen2_pm_init();
> +
> +       /* turn on power to SCU of second cluster */
> +       if (has_a15 && has_a7) {
> +               this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
> +               if (this_cluster = 0)
> +                       rcar_sysc_power_up(&rcar_gen2_ca7_scu);
> +               else
> +                       rcar_sysc_power_up(&rcar_gen2_ca15_scu);

This is a change in behavior compared to the old r8a7790 implementation, which
powered on both clusters. Please mention this in the patch description.

> +       }
> +}
> +
> +static int rcar_gen2_smp_boot_secondary(unsigned int cpu,
> +                                     struct task_struct *idle)
> +{
> +       /* Error out when hardware debug mode is enabled */
> +       if (of_machine_is_compatible("renesas,r8a7791") &&
> +           rcar_gen2_read_mode_pins() & BIT(21)) {

While we indeed had this check on r8a7791 only, I think it also applies
to r8a7790, cfr. the Lager board documentation.
According to the R-Car Gen2 datasheet, this is the case on all family
members but R-Car V2H.

> +               pr_warn("Unable to boot CPU%u when MD21 is set\n", cpu);
> +               return -ENOTSUPP;
> +       }
> +
> +       return shmobile_smp_apmu_boot_secondary(cpu, idle);
> +}
> +
> +struct smp_operations rcar_gen2_smp_ops __initdata = {
> +       .smp_prepare_cpus       = rcar_gen2_smp_prepare_cpus,
> +       .smp_boot_secondary     = rcar_gen2_smp_boot_secondary,
> +#ifdef CONFIG_HOTPLUG_CPU
> +       .cpu_disable            = shmobile_smp_cpu_disable,
> +       .cpu_die                = shmobile_smp_apmu_cpu_die,
> +       .cpu_kill               = shmobile_smp_apmu_cpu_kill,
> +#endif
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
