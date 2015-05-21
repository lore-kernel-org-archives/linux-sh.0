From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 May 2015 08:13:38 +0000
Subject: Re: [PATCH 02/04] ARM: shmobile: Add APMU DT support via Enable method
Message-Id: <CAMuHMdXwMB17YXpqR9xr07vPg84CQL3W1Q20+gL+JvFEpOt+5Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150521012138.25972.91336.sendpatchset@little-apple>
	<20150521012200.25972.64826.sendpatchset@little-apple>
In-Reply-To: <20150521012200.25972.64826.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lorenzo.pieralisi@arm.com, =?UTF-8?B?5bCP5p6X5pWs5aSq?= <keita.kobayashi.ym@renesas.com>, Simon Horman <horms@verge.net.au>

On Thu, May 21, 2015 at 3:22 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/arch/arm/mach-shmobile/platsmp-apmu.c
> +++ work/arch/arm/mach-shmobile/platsmp-apmu.c  2015-05-20 22:26:43.152366518 +0900

> +static void apmu_parse_dt(void (*fn)(struct resource *res, int cpu, int bit))
> +{
> +       struct device_node *np_apmu, *np_cpu;
> +       struct resource res;
> +       u32 id;
> +       int bit, index;
> +       bool is_allowed;
> +
> +       for_each_matching_node(np_apmu, apmu_ids) {
> +               /* only enable the cluster that includes the boot CPU */
> +               is_allowed = false;

You can declare the variable here instead of at the top of the function.

> +               for (bit = 0; bit < CONFIG_NR_CPUS; bit++) {
> +                       np_cpu = of_parse_phandle(np_apmu, "cpus", bit);
> +                       if (np_cpu) {
> +                               if (!of_property_read_u32(np_cpu, "reg", &id)) {
> +                                       if (id = cpu_logical_map(0))
> +                                               is_allowed = true;

You can do "of_node_put(np_cpu); break;" here, to stop scanning.

> +                               }
> +                               of_node_put(np_cpu);
> +                       }
> +               }
> +               if (!is_allowed)
> +                       continue;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
