From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 05:34:56 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: bockw: DMAEngine support for sound
Message-Id: <20131205053454.GK12774@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87iovq77a0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iovq77a0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 20, 2013 at 08:49:18PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > These patches add DMAEngine support for sound
> > > These need...
> > > 
> > >  - linus/master branch merge (sound driver update)
> > 
> > I assume this means I should wait for v3.12-rc1?
> 
> Thank you
> I think so.
> 
> > >  - HPB-DMAC fixup patches (remove noise issue)
> > 
> > Are these also going to be in v3.12-rc1?
> 
> I'm asking it to DMA maintainer (= Vinod)
> (He said "applied, thanks", but I couldn't find it)
> I will let you know the answer when I got.
> And I noticed that this HPB-DMAC fixup patch is not only
> for noise, it solve kernel hungup issue.
> 
> > >  - my previous patch (DMAEngile stall issue)
> > 
> > What is the status of that patch?
> 
> It is accepted
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: fix/rcar
> 
> > > I guess #1 patch needs Mark's Acked-by
> > 
> > We now have the ACK :)
> 
> Yes :)
> 
> Now, this DMA-Engine support needs HPB-DMA fixup patch.
> The kernel will be hungup without it.
> But, I don't know where I can find it
> (no response from Vinod now)
> 
> I will let you know if all necessary patches are
> included to linus/master, or other maintainer's branch.
> Is it OK for you ?

Are they all there now?

> 
> For now, we can pick-up last patch only which we got Ack from Mark.
> But it is based on linus/master branch.
> 
> Best regards
> ---
> Kuninori Morimoto
> 
