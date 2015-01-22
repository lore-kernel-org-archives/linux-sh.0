From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Jan 2015 21:14:43 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <1616131.ykYhUnzOJQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4oyb4zu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4oyb4zu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 21 January 2015 00:51:20 Kuninori Morimoto wrote:
> Hi Laurent, Vinod
> 
> Thank you for your feedback
> 
> >> This time I added SoC/platform side setting patches too (= 3) - 6)).
> >> SoC/platform side setting needs many entries for this rcar-audmapp,
> >> because it has many combinations.
> >> But, I believe this is very normal DMAEngine style, not special.
> > 
> > Vinod commented on 22/12/2014 (Message-ID:
> > <20141222151447.GL16827@intel.com>)
> > 
> > "I think this makes sense. Going thru the driver, it was clear that we
> > were not really gaining anything for using dmaengine API here. So agree
> > that lets use dmanegine for 1st dmac thru dmaengine library and then
> > configure this in your sound driver.."
> > 
> > My understanding is that a solution specific to the sound driver was
> > preferred, instead of a generic DMA engine driver. Have I missed something
> > ?
>
> Grr... my understanding was that
> "1st DMAC will use dmaengine library (= sound framework has sound-dma-xxx
> functions) 2nd DMAC will use normal dmaengine API"
> 
> But, I need to fixup sound driver ?
>  - 1st DMAC = normal DMAEngine API
>  - 2nd DMAC = part of sound driver
> 
> Sorry, for discuss it again here, but I want flexible switching
> for 1st/2nd DMAC (because of 1st/2nd DMAC path combination).
> So, using same DMAEngine interface from sound driver is easy to
> implement/understanding.
>  - 1st DMAC = normal DMAEngine API
>  - 2nd DMAC = normal DMAEngine API

The first DMA engine (the one handling transfer from/to memory) is a general-
purpose DMA engine. It should be handled by a driver that implement the DMA 
engine API, no doubt about that.

The second "DMA engine" is dedicated to the sound IP cores and is far from 
being general-purpose, given that it only supports peripheral-to-peripheral 
transfers, without even interrupts to report transfer completion. I'm not even 
sure we can call it a DMA engine as there's no Direct Memory Access involved 
here :-) The hardware looks more like a crossbar switch with programmable 
routing of audio channels. That's why Vinod and I were wondering whether it 
really makes sense to implement it using the DMA engine API, given the 
resulting complexity of the DT bindings (the sound DT nodes look a bit scary), 
or if it could be simpler to implement it as part of the Renesas sound 
drivers.

-- 
Regards,

Laurent Pinchart

