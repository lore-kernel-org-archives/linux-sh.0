From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 09:11:01 +0000
Subject: Re: [PATCH 0/19] ASoC: rsnd: move 2nd DMAC from DMAEngine to rsnd driver
Message-Id: <87twyiz2mj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
	<7023820.M4yQMnvTuN@wuerfel>
	<87wq3ez3us.wl%kuninori.morimoto.gx@renesas.com>
	<6087418.KkNNyy5Y2y@wuerfel>
In-Reply-To: <6087418.KkNNyy5Y2y@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>


Hi Arnd
Cc Magnus, Simon

> Doing this will require marking that function as EXPORT_SYMBOL_GPL(),
> but I see no problem with that.
> 
> I see you use dma_request_slave_channel_compat here. Does that mean
> you have to support boards with this sound device that do not use DT?
> If so, you will also have to split the request function like
> 
> 	if (of_node)
> 		chan = of_dma_request_slave_channel(of_node, "rx");
> 	else
> 		chan = dma_request_channel(mask, filter, arg);

Hmm... I can do this.
Current sound driver is used for Gen1 / Gen2 board.
Today, all Gen2 boards are boot from DT.
My last concern is Gen1 which boot from non-DT. But today,
Gen1 board (= bockw) can boot from DT (?)

Simon, Magnus

I think bockw can boot from DT today, and legacy bockw
(= non-DT) code will be removed from upstream ?
If so, sound driver can care only DT.
anyway, sound driver doesn't need
dma_request_slave_channel_compat() anymore ?

