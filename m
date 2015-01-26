From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Jan 2015 02:18:32 +0000
Subject: Re: [alsa-devel] [PATCH 0/2 v5] dmaengine: rcar-audmapp:	independent from SH_DMAE_BASE
Message-Id: <87bnlmb7wu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<17156476.ZJmUQj3YaX@avalon>
	<87ppa9nefa.wl%kuninori.morimoto.gx@renesas.com>
	<1616131.ykYhUnzOJQ@avalon>
	<8761bygwoo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761bygwoo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, Linux-SH <linux-sh@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Simon <horms@verge.net.au>, dmaengine@vger.kernel.org


Hi Mark

I need your comment about this

> > > Grr... my understanding was that
> > > "1st DMAC will use dmaengine library (= sound framework has sound-dma-xxx
> > > functions) 2nd DMAC will use normal dmaengine API"
> > > 
> > > But, I need to fixup sound driver ?
> > >  - 1st DMAC = normal DMAEngine API
> > >  - 2nd DMAC = part of sound driver
> > > 
> > > Sorry, for discuss it again here, but I want flexible switching
> > > for 1st/2nd DMAC (because of 1st/2nd DMAC path combination).
> > > So, using same DMAEngine interface from sound driver is easy to
> > > implement/understanding.
> > >  - 1st DMAC = normal DMAEngine API
> > >  - 2nd DMAC = normal DMAEngine API
> > 
> > The first DMA engine (the one handling transfer from/to memory) is a general-
> > purpose DMA engine. It should be handled by a driver that implement the DMA 
> > engine API, no doubt about that.
> > 
> > The second "DMA engine" is dedicated to the sound IP cores and is far from 
> > being general-purpose, given that it only supports peripheral-to-peripheral 
> > transfers, without even interrupts to report transfer completion. I'm not even 
> > sure we can call it a DMA engine as there's no Direct Memory Access involved 
> > here :-) The hardware looks more like a crossbar switch with programmable 
> > routing of audio channels. That's why Vinod and I were wondering whether it 
> > really makes sense to implement it using the DMA engine API, given the 
> > resulting complexity of the DT bindings (the sound DT nodes look a bit scary), 
> > or if it could be simpler to implement it as part of the Renesas sound 
> > drivers.
> 
> If you are caring about naming (= DMA), it is "Audio *DMAC* peri peri".
> I wonder dma_transfer_direction has DMA_DEV_TO_DEV (this driver is not using it though...)
> it is for peripheral-to-peripheral ?
> And API point of view, 2nd DMAC doesn't need new DMAEngine API.
> From DRY (= Don't Repeat Yourself) point of view, I don't want to re-create
> "similar but different" implementation for naming issue.
> 
> From DT bindings complexity point of view, which is complex ?
> DMAC driver side ? DT node side ?
> Indeed sound driver needs many node, but is is regular arrangement, not complex,
> and, it needs many node for 1st DMAC too. I don't understand why 1st is OK, 2nd is not OK ?
> From DMAC driver side complexity point of view,
> 1st DMAC has same complexity (= it accepts many node from many drivers) ?
> 
> If I need to move 2nd DMAC from DMAEngine to sound driver side,
> please explain it to Mark Brown (= ALSA SoC maintainer)

http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusB054
http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusB998

Sorry for sudden request, but can you please check above mail thread ?
This topic is for Renesas sound DMAC driver.
Renesas sound driver is using 2 DMAEngine now (= 1st/2nd).
And, this mail thread was started for replacement of 2nd DMAC.
(This replacement is because 2nd DMAC driver's bug fix).

In this mail thread, (I was misunderstanding about agreement though... but)
Vinod/Laurent are thinking that 2nd DMAC should be implemented in sound driver side.
(I'm thinking that both 1st/2nd DMAC on DMAEngine is useful)
But if we need to move 2nd DMAC from DMAEngine to sound driver,
I need to get agreement from you.
What is you opinion ? If you agree about it, I will send the patch to
ALSA/DMAEngine ML.

Best regards
---
Kuninori Morimoto
