From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 11:32:38 +0000
Subject: Re: [PATCH v3 02/09] ARM: shmobile: Add APMU DT support via Enable method
Message-Id: <CAMuHMdVzau7LJiy3W+KrxhR3rU+4kXa6hCt5o4aowYLMfU8Wyg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917063240.26016.93772.sendpatchset@little-apple>
	<20150917063300.26016.23728.sendpatchset@little-apple>
In-Reply-To: <20150917063300.26016.23728.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym@renesas.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Thu, Sep 17, 2015 at 8:33 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ work/arch/arm/mach-shmobile/platsmp-apmu.c  2015-09-16 20:46:23.400513000 +0900
> @@ -24,6 +24,7 @@
>  #include <asm/suspend.h>
>  #include "common.h"
>  #include "platsmp-apmu.h"
> +#include "rcar-gen2.h"
>
>  static struct {
>         void __iomem *iomem;
> @@ -117,15 +118,67 @@ static void apmu_parse_cfg(void (*fn)(st
>         }
>  }
>
> -void __init shmobile_smp_apmu_prepare_cpus(unsigned int max_cpus,
> -                                          struct rcar_apmu_config *apmu_config,
> -                                          int num)
> +static const struct of_device_id apmu_ids[] = {
> +       { .compatible = "renesas,apmu" },
> +       { /*sentinel*/ }
> +};
> +
> +static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
> +{
> +       struct device_node *np_apmu, *np_cpu;
> +       struct resource res;
> +       u32 id;
> +       int bit, index;
> +
> +       for_each_matching_node(np_apmu, apmu_ids) {
> +               /* only enable the cluster that includes the boot CPU */
> +               bool is_allowed = false;
> +               for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
> +                       np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
> +                       if (np_cpu) {
> +                               if (!of_property_read_u32(np_cpu, "reg", &id)) {
> +                                       if (id = cpu_logical_map(0)) {
> +                                               is_allowed = true;
> +                                               of_node_put(np_cpu);
> +                                               break;
> +                                       }
> +

Trailing whitespace (thanks, checkpatch.pl!)

> +                               }
> +                               of_node_put(np_cpu);
> +                       }
> +               }
> +               if (!is_allowed)
> +                       continue;
> +
> +               for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
> +                       np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
> +                       if (np_cpu) {
> +                               if (!of_property_read_u32(np_cpu, "reg", &id)) {
> +                                       index = get_logical_index(id);
> +                                       if ((index >= 0) &&
> +                                           !of_address_to_resource(np_apmu,
> +                                                                   0, &res))
> +                                               fn(&res, index, bit);
> +                               }
> +                               of_node_put(np_cpu);
> +                       }
> +               }
> +               of_node_put(np_apmu);

ERROR: Bad of_node_put() on /apmu@e6152000
CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.3.0-rc3-koelsch-02290-gca074b0726212a2f #1797
Hardware name: Generic R8A7791 (Flattened Device Tree)
[<c0017e9c>] (unwind_backtrace) from [<c00139f8>] (show_stack+0x10/0x14)
[<c00139f8>] (show_stack) from [<c01efd24>] (dump_stack+0x70/0x8c)
[<c01efd24>] (dump_stack) from [<c01f1eec>] (kobject_release+0x12c/0x19c)
[<c01f1eec>] (kobject_release) from [<c032a89c>]
(of_find_matching_node_and_match+0x78/0x90)
[<c032a89c>] (of_find_matching_node_and_match) from [<c062e424>]
(shmobile_smp_apmu_prepare_cpus_dt+0x150/0x178)
[<c062e424>] (shmobile_smp_apmu_prepare_cpus_dt) from [<c0626c98>]
(kernel_init_freeable+0x60/0x1e4)

for_each_matching_node() takes care of calling of_node_put() on each
element iterated over, cfr. of_find_matching_node_and_match().

> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
