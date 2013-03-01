From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 09:41:41 +0000
Subject: Re: [PATCH 00/05] irqchip: Renesas INTC External IRQ pin v2 update
Message-Id: <20130301094140.GB27938@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130226115834.5630.45471.sendpatchset@w520>
In-Reply-To: <20130226115834.5630.45471.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, tglx@linutronix.de

On Tue, Feb 26, 2013 at 08:58:34PM +0900, Magnus Damm wrote:
> irqchip: Renesas INTC External IRQ pin v2 update
> 
> [PATCH 01/05] irqchip: intc-irqpin: Whitespace fixes
> [PATCH 02/05] irqchip: intc-irqpin: Cache mapped IRQ
> [PATCH 03/05] irqchip: intc-irqpin: Add force comments
> [PATCH 04/05] irqchip: intc-irqpin: Make use of devm functions
> [PATCH 05/05] irqchip: intc-irqpin: GPL header for platform data
> 
> These patches update the v1 of the INTC External IRQ pin driver
> in various ways based on feedback kindly received from:
> - Simon Horman
> - Kuninori Morimoto
> - Thomas Gleixner
> 
> With the series applied I see the driver as "v2", but
> I prefer to keep these changes as incremental ones instead
> of redoing a single "v2" patch for the driver. The reason
> behind this is that there are on-going back porting efforts
> that are better dealt with using incremental patches.

Hi Magnus, Hi all,

I do not expect this code to go through the renesas tree.  However, in
order to provide a basis for work on renesas SoCs I have added this series
to the topic/intc-external-irq topic branch in the reneas tree on
kernel.org and merged it into topic/all+next.

In other words, I am not picking this series up to merge it or add it to
linux-next, rather I am storing it for reference.
