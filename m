From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 May 2014 13:40:33 +0000
Subject: Re: [PATCH 1/3] mmc: block: add block number limitation flag for lultiple block read
Message-Id: <87egzbpepc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
	<87oayfpn14.wl%kuninori.morimoto.gx@renesas.com>
	<538886E6.4000209@cogentembedded.com>
In-Reply-To: <538886E6.4000209@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Sergei

> > +			if (card->host->caps2 & MMC_CAP2_2BLKS_LIMIT) {
> > +				/*
> > +				 * In some controllers, when performing a
> > +				 * multiple block read of one or two blocks,
> > +				 * depending on the timing with which the
> > +				 * response register is read, the response
> > +				 * value may not be read properly.
> > +				 * Use single block read for this HW bug
> > +				 */
> > +				if (brq->data.blocks = 2)
> > +					brq->data.blocks = 1;
> 
>     I don't understand: previous code set 'brq->data.blocks' to 1 in any case 
> without your extra flag. Why there's a need to set it specifically for 2 
> blocks (and not set for a larger # of blocks)? This looks like an optimization 
> of some sort, not a workaround?..

Basically, we want to use multi block read.
Otherwise, the speed will be super slow
if it always use single block.
(Previous code force to single block)

But we need to switch to single block mode
if brq->data.blocks = 2.
Please read the above comment for detail.
