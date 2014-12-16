From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 16 Dec 2014 06:58:32 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <20141216065830.GV16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 16, 2014 at 12:08:08AM +0000, Kuninori Morimoto wrote:
> 
> Hi Vinod
> 
> > > > > When we set simple settings to DMAC, then, it works automatically as cyclic transfer.
> > > > > The usage of this DMA is very limited, so it is super simple.
> > > > > In addition, this is 2nd DMA which is needed on sound.
> > > > >  1st DMA is controled by rcar-dmac.c
> > > > >  2nd DMA is this
> > > > > almost all settings are set by 1st DMA, 2nd DMA is just relay.
> > > > okay that needs to be called out explicitly. While reading driver it wasn't
> > > > very clear
> > > > So which one is the 1st DMA, how will the client configure these two DMAs?
> > > 
> > > 1st DMA is rcar-dma which was created by Laurent.
> > > And it has been sent to you now.
> > > 
> > > ${LINUX}/sound/soc/sh/rcar/core.c
> > > is the user of these 2 dmac.
> > > 1st DMAC gets "from mem address", and "to reg address".
> > > 2nd DMAC gets "from reg address", and "to reg address".
> > > DMAC's ID are came from DT.
> > So how is the user expectations, will they configure both the engines?
> 
> This rcar-audmapp driver is very limited usage, and user is only sound device/driver.
> Sound driver configures both 1st/2nd DMAC if needed (it depends on platform).
> Sound driver knows all reg address / mem address which are needed for 1st/2nd DMAC settings.
> 1st/2nd DMAC needs general DMAEngine settings method, not special. 
> Now, sound driver + 1st/2nd DMAC works well on my local environment.
Are you not using the sound dmaengine library then, right?

One more question, audio data will be in system memory and then it needs to
be transfered to periphral FIFO, how will data travel thru these two DMAs?

-- 
~Vinod

