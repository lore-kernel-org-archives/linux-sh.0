From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 08 Jun 2016 10:05:09 +0000
Subject: Re: [PATCH 1/6] dma: rcar-dma: add wait after stopping dma engine
Message-Id: <87twh4huif.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
In-Reply-To: <1443559488-2416-2-git-send-email-hamzahfrq.sub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent
# add Niklas

Sorry for my suport late response.
Thanks Niklas for reminder

> (With a question for Morimoto-san below)
(snip)
> > >> +     } while (++i < NR_READS_TO_WAIT);
> > > 
> > > How long does the DMA engine typically need to stop ? Is there a safe
> > > upper bound ?
> > 
> > I have tested it many times. The highest number of retries was 3 which
> > occurred not very frequently. Normally it is 1-2
> 
> Morimoto-san, could you check with the hardware team if there's a worst case 
> guarantee regarding how long the channel could take to stop ?

You need to wait maximum 0.7ms for it.
both for Gen2/Gen3.
In worst case, it needs 8 request times.
If 1 request is 20,000 cycle

	20,000cycle x 8request x [4ns/cylce] = 640,000ns > 700us
