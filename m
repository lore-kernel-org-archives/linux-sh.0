From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 16 Dec 2014 19:41:56 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <5322921.FxG3xulvMv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

On Tuesday 16 December 2014 22:09:04 Vinod Koul wrote:
> On Tue, Dec 16, 2014 at 09:03:38AM +0000, Kuninori Morimoto wrote:
> > Hi Vinod
> > 
> > > > This rcar-audmapp driver is very limited usage, and user is only sound
> > > > device/driver. Sound driver configures both 1st/2nd DMAC if needed
> > > > (it depends on platform). Sound driver knows all reg address / mem
> > > > address which are needed for 1st/2nd DMAC settings. 1st/2nd DMAC
> > > > needs general DMAEngine settings method, not special. Now, sound
> > > > driver + 1st/2nd DMAC works well on my local environment.> > 
> > > Are you not using the sound dmaengine library then, right?
> > 
> > At this point, yes.
> > But, I got request from Mark to use it
> 
> Yes that is the subsytem recommendation
> 
> > # current dmaengine "method" on my driver is same as library.
> > # but I need to fix non-dmaengine area
> > 
> > > One more question, audio data will be in system memory and then it needs
> > > to be transfered to periphral FIFO, how will data travel thru these two
> > > DMAs?
> > 
> > like this
> > 
> >     1st DMA            2nd DMA
> > 
> > [mem] -> [periphral IP-A] -> [periphral IP-B] -> speaker
> 
> Okay and by current implementation you wont be able to use the generic
> dmaengine sound layer. That layer assumes you will have only one dmaengine
> channel to configure and will configure only one DMA and which is 1st DMA
> here.
> 
> So what do we do we 2nd one here. The point that 2nd DMA is behind the 1st
> DMA, should the users know about it and configure? I am not sure...
> If not, then who should configure this. Another candidate is 1st DMA, but
> then from the point of 1st DMA should it configure 2nd DMA as well, treat it
> as its salve... sounds plausible but am not too sure... comments?

The second DMA is not a slave of the first one, given that there's a 
peripheral in-between.

Not that I'm advocating for it, but given how simple the second DMA engine is, 
and given that it is dedicated to a single function (transferring data between 
sound-related IPs, nothing else is possible) and can't thus be used as a 
general purpose DMA engine, I wouldn't mind handling it internally as part of 
the sound drivers instead of exposing it through the DMA engine API.

-- 
Regards,

Laurent Pinchart

