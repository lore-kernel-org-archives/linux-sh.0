From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 26 Jan 2015 02:39:42 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <5155160.jFIrOp4XSG@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com> <1616131.ykYhUnzOJQ@avalon> <8761bygwoo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761bygwoo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Vinod Koul <vinod.koul@intel.com>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org

Hi Morimoto-san,

On Friday 23 January 2015 00:35:32 Kuninori Morimoto wrote:
> Hi Laurent, Vinod, and Arnd
> 
> # I added Linux ALSA ML and Mark
> 
> >>>> This time I added SoC/platform side setting patches too (= 3) - 6)).
> >>>> SoC/platform side setting needs many entries for this rcar-audmapp,
> >>>> because it has many combinations.
> >>>> But, I believe this is very normal DMAEngine style, not special.
> >>> 
> >>> Vinod commented on 22/12/2014 (Message-ID:
> >>> <20141222151447.GL16827@intel.com>)
> >>> 
> >>> "I think this makes sense. Going thru the driver, it was clear that we
> >>> were not really gaining anything for using dmaengine API here. So
> >>> agree that lets use dmanegine for 1st dmac thru dmaengine library and
> >>> then configure this in your sound driver.."
> >>> 
> >>> My understanding is that a solution specific to the sound driver was
> >>> preferred, instead of a generic DMA engine driver. Have I missed
> >>> something ?
> >> 
> >> Grr... my understanding was that
> >> "1st DMAC will use dmaengine library (= sound framework has
> >> sound-dma-xxx
> >> functions) 2nd DMAC will use normal dmaengine API"
> >> 
> >> But, I need to fixup sound driver ?
> >> 
> >>  - 1st DMAC = normal DMAEngine API
> >>  - 2nd DMAC = part of sound driver
> >> 
> >> Sorry, for discuss it again here, but I want flexible switching
> >> for 1st/2nd DMAC (because of 1st/2nd DMAC path combination).
> >> So, using same DMAEngine interface from sound driver is easy to
> >> implement/understanding.
> >> 
> >>  - 1st DMAC = normal DMAEngine API
> >>  - 2nd DMAC = normal DMAEngine API
> > 
> > The first DMA engine (the one handling transfer from/to memory) is a
> > general- purpose DMA engine. It should be handled by a driver that
> > implement the DMA engine API, no doubt about that.
> > 
> > The second "DMA engine" is dedicated to the sound IP cores and is far from
> > being general-purpose, given that it only supports
> > peripheral-to-peripheral transfers, without even interrupts to report
> > transfer completion. I'm not even sure we can call it a DMA engine as
> > there's no Direct Memory Access involved here :-) The hardware looks more
> > like a crossbar switch with programmable routing of audio channels. That's
> > why Vinod and I were wondering whether it really makes sense to implement
> > it using the DMA engine API, given the resulting complexity of the DT
> > bindings (the sound DT nodes look a bit scary), or if it could be simpler
> > to implement it as part of the Renesas sound drivers.
> 
> If you are caring about naming (= DMA), it is "Audio *DMAC* peri peri".
> I wonder dma_transfer_direction has DMA_DEV_TO_DEV (this driver is not using
> it though...) it is for peripheral-to-peripheral ?
> And API point of view, 2nd DMAC doesn't need new DMAEngine API.
> From DRY (= Don't Repeat Yourself) point of view, I don't want to re-create
> "similar but different" implementation for naming issue.
> 
> From DT bindings complexity point of view, which is complex ?
> DMAC driver side ? DT node side ?
> Indeed sound driver needs many node, but is is regular arrangement, not
> complex, and, it needs many node for 1st DMAC too. I don't understand why
> 1st is OK, 2nd is not OK ? From DMAC driver side complexity point of view,
> 1st DMAC has same complexity (= it accepts many node from many drivers) ?
> 
> If I need to move 2nd DMAC from DMAEngine to sound driver side,
> please explain it to Mark Brown (= ALSA SoC maintainer)

I'm not saying you need to, I just wanted to raise the issue. From what I 
understood Vinod was also having doubts on using the DMA engine API for this 
device, given that it doesn't really match what the DMA engine API has been 
designed for. If everybody else is fine with your patches, and if the sound DT 
nodes are not considered overly complex with the DMA engine bindings, then I 
have no objection.

-- 
Regards,

Laurent Pinchart

