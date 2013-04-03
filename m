From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 03 Apr 2013 00:08:55 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
Message-Id: <87txnocw6n.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
 <87wqsl6ale.wl%kuninori.morimoto.gx@renesas.com>
 <515AC546.90905@cogentembedded.com>
In-Reply-To: <515AC546.90905@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei

> > Then, this (void *pdata) should be
> > (struct sh_eth_plat_data *pdata) IMO
> 
>     ether_device.dev.platform_data is 'void *'. I didn't want to bring in 
> extra header for the little use.

Not enough reason for me.

"void *" means there is no pointer check,
and extra header is just 1 line. No ?

If you want to use this style,
then, additional extra header is fate, IMO

Best regards
---
Kuninori Morimoto
