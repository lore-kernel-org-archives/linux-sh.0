From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Mon, 16 Mar 2015 04:30:43 +0000
Subject: Re: [RFC/PATCH] ARM: shmobile: Consolidate the pm code for R-Car Gen2
Message-Id: <55065C73.3040508@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5502A268.2030304@bp.renesas.com>
In-Reply-To: <5502A268.2030304@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert-san,

Thank you for your feedback.

On 2015/03/13 18:39, Geert Uytterhoeven wrote:
> Hi Inami-san,
>
> On Fri, Mar 13, 2015 at 9:40 AM, Gaku Inami
> <gaku.inami.xw@bp.renesas.com> wrote:

< snip >

>> --- /dev/null
>> +++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
>> @@ -0,0 +1,114 @@
>> +/*
>> + * R-Car Generation 2 Power management support
>> + *
>> + * Copyright (C) 2015  Renesas Electronics Corporation
> Please retain the original copyrights from pm-r8a779[01].c here, too.

I will fix it with v2 patch.

>> +#if defined(CONFIG_SMP)
>> +
>> +static void __init rcar_gen2_sysc_init(void)
>> +{
>> +       u32 val;
>> +       void __iomem *base = rcar_sysc_init(0xe6180000);
>> +
>> +       if (of_machine_is_compatible("renesas,r8a7790"))
>> +               val = 0x013111ef;
>> +       else if (of_machine_is_compatible("renesas,r8a7791"))
>> +               val = 0x00111003;
> As you do SoC OF matching in rcar_gen2_pm_init() too, perhaps "val" should
> be passed from that function? That would save a few of_machine_is_compatible()
> lookups.

I will pass the value of SYSCIER from rcar_gen2_pm_init().

>
>> +
>> +       /* enable all interrupt sources, but do not use interrupt handler */
>> +       iowrite32(val, base + SYSCIER);
>> +       iowrite32(0, base + SYSCIMR);
>> +}
>> +
>> +#else /* CONFIG_SMP */
>> +
>> +static inline void rcar_gen2_sysc_init(void) {}
>> +
>> +#endif /* CONFIG_SMP */
>> +
>> +void __init rcar_gen2_pm_init(void)
>> +{
>> +       void __iomem *p;
>> +       u32 bar;
>> +       static int once;
>> +       struct device_node *np, *cpus;
>> +       bool is_a7 = false;
>> +       bool is_a15 = false;
> I would name these "has_a7" and "has_a15", as both can be true.

I will fix it with v2 patch.

>> +       phys_addr_t boot_vector_addr = 0;
>> +
>> +       if (once++)
>> +               return;
>> +
>> +       cpus = of_find_node_by_path("/cpus");
>> +       if (!cpus)
>> +               return;
>> +
>> +       for_each_child_of_node(cpus, np) {
>> +               if (of_device_is_compatible(np, "arm,cortex-a15"))
>> +                       is_a15 = true;
>> +               else if (of_device_is_compatible(np, "arm,cortex-a7"))
>> +                       is_a7 = true;
>> +       }
>> +
>> +       if (of_machine_is_compatible("renesas,r8a7790"))
>> +               boot_vector_addr = MERAM;
>> +       else
>> +               boot_vector_addr = RAM;
> You could store the SYSCIER value in a variable here:
>
>         if (of_machine_is_compatible("renesas,r8a7790")) {
>                 boot_vector_addr = MERAM;
>                 syscier = 0x013111ef;
>         } else if (of_machine_is_compatible("renesas,r8a7791")) {
>                 boot_vector_addr = RAM;
>                 syscier = 0x00111003;
>         }
>
> More SoC checks will be added in the future...
>
> If CONFIG_SMP is not set, the compiler will optimize out the assignments
> to syscier.
>
>> +       rcar_gen2_sysc_init();
> You could pass syscier here.

It was redundant to call twice of_machine_is_compatible().
I will fix as you mentioned, and then I will post v2 patch.

Regards,
Inami

