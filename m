From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Jul 2013 00:25:15 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: bockw: add DT reference
Message-Id: <878v1fw9b0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> > my apology is that this is marzen-reference style.
> >
> > # board-marzen.c is using irq_pin(1) (= IRQ1),
> > # but board-marzen-reference.dts is using 28 (= GIC)
> 
> Ok, I understand. It looks like Marzen DT reference is broken. Perhaps
> it was written before INTC irqpin or gpio-rcar.c existed.
> 
> I wonder, when you have time, can you work with the author of the
> Marzen DT reference patch to improve the situation?

OK, will do :)

Best regards
---
Kuninori Morimoto
