From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Jan 2015 02:57:32 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <877fwab63w.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<1616131.ykYhUnzOJQ@avalon>
	<8761bygwoo.wl%kuninori.morimoto.gx@renesas.com>
	<5155160.jFIrOp4XSG@avalon>
In-Reply-To: <5155160.jFIrOp4XSG@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org


Hi Laurent

> > If you are caring about naming (= DMA), it is "Audio *DMAC* peri peri".
> > I wonder dma_transfer_direction has DMA_DEV_TO_DEV (this driver is not using
> > it though...) it is for peripheral-to-peripheral ?
> > And API point of view, 2nd DMAC doesn't need new DMAEngine API.
> > From DRY (= Don't Repeat Yourself) point of view, I don't want to re-create
> > "similar but different" implementation for naming issue.
> > 
> > From DT bindings complexity point of view, which is complex ?
> > DMAC driver side ? DT node side ?
> > Indeed sound driver needs many node, but is is regular arrangement, not
> > complex, and, it needs many node for 1st DMAC too. I don't understand why
> > 1st is OK, 2nd is not OK ? From DMAC driver side complexity point of view,
> > 1st DMAC has same complexity (= it accepts many node from many drivers) ?
> > 
> > If I need to move 2nd DMAC from DMAEngine to sound driver side,
> > please explain it to Mark Brown (= ALSA SoC maintainer)
> 
> I'm not saying you need to, I just wanted to raise the issue. From what I 
> understood Vinod was also having doubts on using the DMA engine API for this 
> device, given that it doesn't really match what the DMA engine API has been 
> designed for. If everybody else is fine with your patches, and if the sound DT 
> nodes are not considered overly complex with the DMA engine bindings, then I 
> have no objection.

Thank you for your feedback,
and I'm so sorry for my previous rude mail.

I think 2nd DMAC doesn't be complex issue, because it is very simple device.
But, this is my side (sound driver point) opinion.
Of course I can agree about DMAEngine side opinion/concern.
I don't know what it the best solution.

Now, I asked about it to Mark (= ALSA SoC maintainer).
I can follow ALSA SoC maintainer + DMAEngine maintainer.

Best regards
---
Kuninori Morimoto
