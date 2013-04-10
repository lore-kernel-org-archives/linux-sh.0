From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Apr 2013 02:23:00 +0000
Subject: Re: [RFC][PATCH 1/4] sh-pfc: Add r8a7778 pinmux support
Message-Id: <87ppy3jf9a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761zwb74q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761zwb74q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for your review
I will send v2 patch which includes your point.

> > +#define SH_PFC_MUX1(name, arg1)		static const unsigned int name
> > ##_mux[]  = { arg1##_MARK, }
> > +#define SH_PFC_MUX2(name, arg1, arg2)	static const unsigned int name
> > ##_mux[]  = { arg1##_MARK, arg2##_MARK, }
> 
> This is an interesting approach, but I'm afraid it won't scale. We will have 
> groups with more than 2 pins, and I'd like to avoid defining MUX3, MUX4, ... 
> macros.
> 
> One possible solution woud be to define a single SH_PFC_MUX macro with a 
> variable number of arguments, and add the _MARK suffix explicitly. The other 
> solution is to define the tables explicitly as done in the other pfc-*.c 
> files. I have no strong preference.
(snip)
> Aligning the pins and mux is nice here, but will result it way too long lines 
> later for groups with more than two pins. I'll let you decide whether to keep 
> the alignment here or not.

Thank you.
I can agree that this SH_PFC_MUXx() is not good approach :P

But, I would like to keep readable code approach somehow.
Then, how about below ?

#define SCIF_PFC_DATA(a, b)
#define SCIF_PFC_CTRL(a, b)
#define SCIF_PFC_CLK(a)

It is for "SCIF" definition,
and, we can add new macro or raw tables (case by case)
when we add other PFC on this file ?

Best regards
---
Kuninori Morimoto
