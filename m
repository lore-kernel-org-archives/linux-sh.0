From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 16:42:50 +0000
Subject: Re: [PATCH v6 2/2] irqchip: add J-Core AIC driver
Message-Id: <20160804164250.GH15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b6529.git.dalias@libc.org>
 <c3b89ef74aaa6477575dbe2d410eb1d182503243.147018b6529.git.dalias@libc.org>
 <CAMuHMdWiGCLQracGnD6Z5JiAJfYMsEdO0m52Xo4mkrVXEHgakg@mail.gmail.com>
In-Reply-To: <CAMuHMdWiGCLQracGnD6Z5JiAJfYMsEdO0m52Xo4mkrVXEHgakg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Thu, Aug 04, 2016 at 04:32:57PM +0200, Geert Uytterhoeven wrote:
> Hi Rich,
> 
> On Thu, Aug 4, 2016 at 6:30 AM, Rich Felker <dalias@libc.org> wrote:
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-jcore-aic.c
> 
> > +int __init aic_irq_of_init(struct device_node *node, struct device_node *parent)
> > +{
> > +       unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
> > +       unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
> > +       struct irq_domain *domain;
> > +
> > +       pr_info("Initializing J-Core AIC\n");
> > +
> > +       /* AIC1 needs priority initialization to receive interrupts. */
> > +       if (of_device_is_compatible(node, "jcore,aic1")) {
> > +               unsigned cpu;
> > +
> > +               for_each_present_cpu(cpu) {
> > +                       void __iomem *base = of_iomap(node, cpu);
> 
> Just double checking, these regions are per-cpu hardware registers,
> and not related to other functionality at all?
> 
> I.e. when booting on an SMP-capable system a kernel compiled with
> CONFIG_SMP=n, or using the kernel command line option maxcpus> to reduce the number of CPUs, no ill effects happen by not mapping the
> region and not writing to the register below?

If you're not using a secondary cpu, there's no harm in ignoring its
aic completely.

Rich
