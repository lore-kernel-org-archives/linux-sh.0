From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:06:54 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: bockw: add SMSC support on DT
Message-Id: <87li2cyu3o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txh0yzbj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txh0yzbj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > This patch enables SMSC on BockW board via DT.
> > SMSC interrupt is connected to FPGA, and is connected
> > to IRQ0 on BockW.
> > This patch enabled INTC IRQ too
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   27 +++++++++++++++++++++++-
> >  arch/arm/mach-shmobile/board-bockw-reference.c |   20 ++++++++++++++++++
> >  2 files changed, 46 insertions(+), 1 deletion(-)
> 
> Please split this into two patches.
> 
> 1. A DT patch that modifies r8a7778-bockw-reference.dts
> 2. A board patch that modifies board-bockw-reference.c

OK, will do

Best regards
---
Kuninori Morimoto
