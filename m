From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Jan 2015 07:16:13 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87twze9fk8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<1616131.ykYhUnzOJQ@avalon>
	<8761bygwoo.wl%kuninori.morimoto.gx@renesas.com>
	<5155160.jFIrOp4XSG@avalon>
	<20150126062655.GG28763@intel.com>
	<87zj969h78.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zj969h78.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org


Hi Vinod, again

> > > I'm not saying you need to, I just wanted to raise the issue. From what I 
> > > understood Vinod was also having doubts on using the DMA engine API for this 
> > > device, given that it doesn't really match what the DMA engine API has been 
> > > designed for. If everybody else is fine with your patches, and if the sound DT 
> > > nodes are not considered overly complex with the DMA engine bindings, then I 
> > > have no objection.
> > Laurent is right in his observations, When I last reviewed the series
> > (though have looked at this one yet), the advise was to use dmaengine APIs
> > with sound dmanengine library for 1st DMAC.  The second DMAC is specfic to
> > this device so should be handled internally or as part of the sound driver
> > (or whatever client)
> 
> So, is this mean we can't use DMAEngine style if it was non-generic DMAC ?
> For Example, we have USB-DMAC (it is used from USB only)

This is out-of-topic from sound DMAC,
but in USB-DMAC case, our SoC have USB IP and its DMAC.
Old USB used generic DMAC before,
but, New USB have USB specific DMAC today.
And we already have usb driver. what should we do in this case ?

Best regards
---
Kuninori Morimoto
