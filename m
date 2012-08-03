From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 03 Aug 2012 05:00:40 +0000
Subject: Re: irqdomain breaks ap4 boot
Message-Id: <20120803050039.GA1614@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 02, 2012 at 02:50:26AM -0700, kuninori.morimoto.gx@renesas.com wrote:
> 
> Hi Paul
> 
> I noticed that sh irqdomain commit breaks mackerel boot.
> below is "git bisect" result and kernel log
> 
> ------- log -----------------------------
> ...
> NR_IRQS:16 nr_irqs:16 16
> intc: Registered controller 'sh7372-intca' with 108 IRQs
> intc: Registered controller 'sh7372-intca-irq-lo' with 16 IRQs
> intc: can't get irq_desc for 0
> intc: can't get irq_desc for 1
> intc: can't get irq_desc for 2
> intc: can't get irq_desc for 3
> intc: can't get irq_desc for 4
> intc: can't get irq_desc for 5
> intc: can't get irq_desc for 6
> intc: can't get irq_desc for 7
> intc: can't get irq_desc for 8
> intc: can't get irq_desc for 9
> intc: can't get irq_desc for 10
> intc: can't get irq_desc for 11
> intc: can't get irq_desc for 12
> intc: can't get irq_desc for 13
> intc: can't get irq_desc for 14
> intc: can't get irq_desc for 15
> intc: Registered controller 'sh7372-intca-irq-hi' with 16 IRQs

Great, it's ARM's silly NR_IRQS_LEGACY getting in the way, and we don't
seem to have any ability to simply not pre-allocate IRQs given that ARM's
machine_desc lamely doesn't allow 0 as a valid nr_irqs initializer even
on sparseirq configurations.

It's not entirely obvious why you are tripping up on this though, as we
should already gracefully handle the -EEXIST case.

I'll have a bit of a think over how to fix it properly.
