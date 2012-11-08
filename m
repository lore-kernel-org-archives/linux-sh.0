From: Simon Horman <horms@verge.net.au>
Date: Thu, 08 Nov 2012 06:17:19 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: board used FSI driver's clock
Message-Id: <20121108061717.GA13151@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 08, 2012 at 03:10:42PM +0900, Simon Horman wrote:
> On Wed, Nov 07, 2012 at 09:56:33PM -0800, Kuninori Morimoto wrote:
> > 
> > Hi Simon
> > 
> > > > Kuninori Morimoto (8):
> > > >   1) ARM: shmobile: add fsi external clock on r8a7740
> > > >   2) ARM: shmobile: add fsi external clock sh7372
> > > >   3) ARM: shmobile: mackerel: enable DMAEngine on USB Host
> > > >   4) ARM: shmobile: use FSI driver's audio clock on armadillo800eva
> > > >   5) ARM: shmobile: use FSI driver's audio clock on mackerel
> > > >   6) ARM: shmobile: use FSI driver's audio clock on ap4evb
> > > >   7) ARM: shmobile: sh7372: remove fsidivx clock
> > > >   8) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
> > (snip)
> > > Thanks, I plan to apply 1, 2, 7 & 8 to the soc branch of the renesas tree and;
> > > 3 - 6 to the boards branch of the reneas stree.
> > > 
> > > However, I am getting conflicts when applying your patches.
> > > Could you either:
> > > 
> > > 1. Split the series in two
> > > 
> > >    a) 1, 2, 7 & 8 based on the soc branch of the renesas tree and;
> > >    b) 3 - 6 based on the boards branch of the renesas tree
> > > 
> > > 2. Rebase the series on the next branch in the renesas tree.
> > 
> > I see, but I couldn't.
> > Because FSI patch-set depends on FSI-DVI patch
> > 
> > d5a1a6ca8c142a9b0b1120d303ee90e86a7e83c2
> > (ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks)
> 
> That commit is in the boards branch as far as I can see.
> I will try to apply the board patches, they may be ok.
> It was the first two soc patches that I had trouble with.
> 
> > and I find it on simon/boards branch (not soc branch).
> >                  ~~~~~~~~~~~~
> 
> Strange, it seems to be here
> http://git.kernel.org/?p=linux/kernel/git/horms/renesas.git;a=shortlog;h=refs/heads/soc
> 
> > What should I do in this case ?
> 
> Can you try to check your remote and fetch again?
> 
> If that fails I can manually apply the changes and send them to you for
> review.

Sorry, I've noticed some problems with my branches.
I'll shake them out and get back to you ASAP.
