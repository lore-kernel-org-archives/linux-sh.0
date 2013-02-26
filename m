From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 26 Feb 2013 17:47:25 +0000
Subject: Re: [PATCH 00/05] irqchip: Renesas INTC External IRQ pin v2 update
Message-Id: <alpine.LFD.2.02.1302261846550.22263@ionos>
List-Id: <linux-sh.vger.kernel.org>
References: <20130226115834.5630.45471.sendpatchset@w520>
In-Reply-To: <20130226115834.5630.45471.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, horms@verge.net.au

On Tue, 26 Feb 2013, Magnus Damm wrote:

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
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

For the full series:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
> 
>  Depends on:
>  [PATCH] irqchip: Renesas INTC External IRQ pin driver
> 
>  drivers/irqchip/irq-renesas-intc-irqpin.c             |   88 ++++++++---------
>  include/linux/platform_data/irq-renesas-intc-irqpin.h |   19 +++
>  2 files changed, 62 insertions(+), 45 deletions(-)
> 
