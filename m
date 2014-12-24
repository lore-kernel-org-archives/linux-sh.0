From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 24 Dec 2014 05:35:51 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <20141224052351.GS16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 24, 2014 at 01:39:05AM +0000, Kuninori Morimoto wrote:
> 
> Hi Vinod, Laurent
> 
> > > > The second DMA controller is specific to the sound subsystem. I thus wonder if 
> > > > the additional complexity of supporting it through the DMA engine API (both in 
> > > > terms of code complexity on the DMA driver side and the sound driver side and 
> > > > in terms of DT bindings complexity) is worth it, or if it would be simpler and 
> > > > cleaner to support it with a driver specific to R-Car sound. You're more 
> > > > knowledgeable than I am on the subject, so I'll trust your judgment.
> > > 
> > > Yes, I agree to your opinion. R-Car DMAC should keep "general-purpose" DMA engine.
> > > It is easy to control if 1st/2nd DMA was separated from sound driver point of view.
> > > I guess sound HW which needs 2 DMAC is very rare case(?). I want "keep it simple"
> > > 
> > > Vinod, this means, we want to have 2 different DMA (= 1st/2nd) for sound.
> > > 1st DMA is general DMAC, 2nd DMA is sound specific DMAC.
> > > What is you opinion ?
> > I think this makes sense. Going thru the driver, it was clear that we were
> > not really gaining anything for using dmaengine API here. So agree that lets
> > use dmanegine for 1st dmac thru dmaengine library and then configure this in
> > your sound driver..
> 
> Thank you for your opinion.
> My understanding is that we can replace rcar-audmapp driver same as before.
Use my next to rebase
> Current DMAEngine branch has fixup(?) branch, and we need to rebase to it.
> And, this 2nd DMA needs 1st DMA which was created by Laurent.
> So, I will send v3 patch if Laurent's DMA driver was accepted
I have the PULL request from Laurent, should be able to process todays

-- 
~Vinod

