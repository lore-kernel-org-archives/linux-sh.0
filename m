From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 09 Apr 2013 09:26:34 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: r8a7790: Register GPIO devices
Message-Id: <87wqsc9hrt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365413782-17036-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1365413782-17036-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > > +#define R8A7790_GPIO(idx)						\
> > > > +static struct resource r8a7790_gpio##idx##_resources[] = {		\
> > > > +	DEFINE_RES_MEM(0xe6050000 + 0x1000 * (idx), 0x50),		\
> > > > +	DEFINE_RES_IRQ(gic_spi(4 + (idx))),				\
> > > 
> > >     Aren't we supposed to abandon the use of gic_spi() for gic_iid() now?
> > 
> > I'll let the IRQ experts answer that. I've noticed that the index passed to 
> > gic_spi() matches the datasheet, and the other devices in the file use 
> > gic_spi(), so I went for gic_spi().
> 
> Morimoto-san, please advise.

I can agree to Laurent.
R8A7790 datasheet is using GIC-SPI.

----
Best regards
---
Kuninori Morimoto
