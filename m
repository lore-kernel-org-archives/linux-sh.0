From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 07 Jan 2015 01:45:00 +0000
Subject: Re: [PATCH 2/9] mmc: tmio: tmio_mmc_host has .dma
Message-Id: <87h9w3pdmo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87zj9xogln.wl%kuninori.morimoto.gx@renesas.com>
	<7306460.62PqiTEhxi@wuerfel>
	<87vbkkvjw6.wl%kuninori.morimoto.gx@renesas.com>
	<1850128.8f5cDzhtTH@wuerfel>
In-Reply-To: <1850128.8f5cDzhtTH@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Arnd, Ulf

Thank you for your feedback

> > Then, I want to try "dmaengine cleanup" patch-set as 2nd step if possible.
> > I guess [8/9] and [9/9] are not good for "header cleanup" (?) I don't know.
> > Arnd, Ulf, what is your opinion ?
> 
> Patch 8 looks great to me.
> 
> Patch 9 as I mentioned is a bit strange because it duplicates the some
> of the data between tmio_mmc_data and tmio_mmc_dma, which are both
> visible to the tmio_mmc_dma.c file. Simply folding tmio_mmc_dma into
> tmio_mmc_data seems like the simplest solution to that.

OK, I see. I will fixup 9/9.

Ulf
Can you please care about 1/9 - 8/9 as 1st step ?
(I got review from Geert about 8/9, so, 1/9 - 7/9 ?)

I will re-try about 9/9 (or 8/9, 9/9) part.
And, then, I will try dmaengine cleanup.

Best regards
---
Kuninori Morimoto
