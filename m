From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:07:14 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7779: split r8a7779_init_irq_extpin() for DT
Message-Id: <87k3hwyu35.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4c4yz2k.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4c4yz2k.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > r8a7779 INTC needs IRL pin mode settings to determine
> > behavior of IRQ0 - IRQ3, and r8a7779_init_irq_extpin()
> > is controlling it via irlm parameter.
> > But this function registers renesas_intc_irqpin driver
> > if irlm was set, and this value depends on platform.
> > This is not good for DT.
> > This patch splits r8a7779_init_irq_extpin() function
> > into "mode settings" and "funtion register" parts,
> > and add status = "disabled" on r8a7779.dtsi as default
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7779.dtsi                |    1 +
> >  arch/arm/mach-shmobile/include/mach/r8a7779.h |    1 +
> >  arch/arm/mach-shmobile/setup-r8a7779.c        |    6 +++++-
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> Please split this into two patches.
> 
> 1. A DT patch that modifies r8a7779.dtsi
> 2. An SoC patch that modifies r8a7779.h and setup-r8a7779.c

OK, will do


Best regards
---
Kuninori Morimoto
