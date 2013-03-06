From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Mar 2013 08:48:33 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-r8a7779: add DIV4 clock support
Message-Id: <871ubslxr6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> > -------------------------------------------------------------------
> > 916b1f8c81ea563611288d1a9b082df3f723e4fe
> > Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Date:   Tue Dec 20 00:53:52 2011 -0800
> >
> >     ARM: mach-shmobile: clock-r8a7779: clkz/clkzs support
> >
> >     Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >     Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> > -------------------------------------------------------------------
> 
> Thanks, but I believe you need to check the MODEMR to determine MD1
> setting. Or maybe this is supported as-is? Anyway, TWD support depends
> on this one but we can deal with that some other day.

Indeed...
New H1 document was updated.

Hmm.. H1 plla depends on MD1 too.

OK, I will work for these clocks.

Best regards
---
Kuninori Morimoto
