From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2015 10:08:48 +0000
Subject: Re: ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <CAMuHMdWjBxA-T64GYrK+QC2Xk8Sm7EzTWczBREMdDfbuG53SHQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150120113800.11062.65299.sendpatchset@little-apple>
In-Reply-To: <20150120113800.11062.65299.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Jan 21, 2015 at 10:25 AM, Simon Horman <horms@verge.net.au> wrote:
>> Ape6evm doesn't provide machine_desc.map_io(), so you have to map the
>> GIC yourself. Does the below work?
>>
>> -       void __iomem *gic_dist_base = IOMEM(0xf1001000);
>> -       void __iomem *gic_cpu_base = IOMEM(0xf1002000);
>> +       void __iomem *gic_dist_base = ioremap_nocache(0xf1001000, 0x1000);
>> +       void __iomem *gic_cpu_base = ioremap_nocache(0xf1002000, 0x1000);
>
> I also added:
>
>         printk("%s gic_dist_base:%p gic_cpu_base:%p\n", __func__,
>                        gic_dist_base, gic_cpu_base);

That doesn't mean much, as you print virtual addresses, which are
arbitrary.

> NR_IRQS:16 nr_irqs:16 16
> r8a73a4_init_irq gic_dist_base:f0000000 gic_cpu_base:f0002000
> irq: no irq domain found for /interrupt-controller@f1001000 !
> irq: no irq domain found for /interrupt-controller@f1001000 !
> irq: no irq domain found for /interrupt-controller@f1001000 !
> irq: no irq domain found for /interrupt-controller@f1001000 !
> arch_timer: No interrupt available, giving up

Unlike r8a7740 and sh73a0, the GIC node in the .dtsi has an interrupt
property. But I don't know how this is to be handled when the GIC is
instantiated from gic_init().

> sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 16777216000000000ns
> Console: colour dummy device 80x30
> Calibrating delay loop...

Yep, no timer interrupt :-(

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
