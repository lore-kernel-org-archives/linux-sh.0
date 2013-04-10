From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Apr 2013 09:07:27 +0000
Subject: Re: [RFC][PATCH 1/4] sh-pfc: Add r8a7778 pinmux support
Message-Id: <87ip3ukb3o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761zwb74q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761zwb74q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > Thank you.
> > I can agree that this SH_PFC_MUXx() is not good approach :P
> > 
> > But, I would like to keep readable code approach somehow.
> > Then, how about below ?
> > 
> > #define SCIF_PFC_DATA(a, b)
> > #define SCIF_PFC_CTRL(a, b)
> > #define SCIF_PFC_CLK(a)
> > 
> > It is for "SCIF" definition,
> > and, we can add new macro or raw tables (case by case)
> > when we add other PFC on this file ?
> 
> That sounds very good to me. Please put the macro definitions right after the 
> first
> /* - SCIF ------------ ... */ line.

Cool !
Thank you. I send v2 soon

Best regards
---
Kuninori Morimoto
