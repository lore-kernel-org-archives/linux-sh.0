From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Aug 2016 14:32:57 +0000
Subject: Re: [PATCH v6 2/2] irqchip: add J-Core AIC driver
Message-Id: <CAMuHMdWiGCLQracGnD6Z5JiAJfYMsEdO0m52Xo4mkrVXEHgakg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b6529.git.dalias@libc.org> <c3b89ef74aaa6477575dbe2d410eb1d182503243.147018b6529.git.dalias@libc.org>
In-Reply-To: <c3b89ef74aaa6477575dbe2d410eb1d182503243.147018b6529.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hi Rich,

On Thu, Aug 4, 2016 at 6:30 AM, Rich Felker <dalias@libc.org> wrote:
> --- /dev/null
> +++ b/drivers/irqchip/irq-jcore-aic.c

> +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> +{
> +       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
> +       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
> +       struct irq_domain *domain;
> +
> +       pr_info("Initializing J-Core AIC\n");
> +
> +       /* AIC1 needs priority initialization to receive interrupts. */
> +       if (of_device_is_compatible(node, "jcore,aic1")) {
> +               unsigned cpu;
> +
> +               for_each_present_cpu(cpu) {
> +                       void __iomem *base = of_iomap(node, cpu);

Just double checking, these regions are per-cpu hardware registers,
and not related to other functionality at all?

I.e. when booting on an SMP-capable system a kernel compiled with
CONFIG_SMP=n, or using the kernel command line option maxcpusto reduce the number of CPUs, no ill effects happen by not mapping the
region and not writing to the register below?

> +
> +                       if (!base) {
> +                               pr_err("Unable to map AIC for cpu %u\n", cpu);
> +                               return -ENOMEM;
> +                       }
> +                       __raw_writel(0xffffffff, base + JCORE_AIC1_INTPRI_REG);
> +                       iounmap(base);
> +               }
> +               min_irq = JCORE_AIC1_MIN_HWIRQ;
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
