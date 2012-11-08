From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 08 Nov 2012 05:28:29 +0000
Subject: Re: [PATCH 0/3] sh/ARM: shmobile: add sh_clk_fsidiv_register()
Message-Id: <20121108052828.GH11568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87ip9rmjcb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ip9rmjcb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 08, 2012 at 10:06:31AM +0900, Simon Horman wrote:
> On Wed, Nov 07, 2012 at 04:09:12PM -0800, Kuninori Morimoto wrote:
> > 
> > Hi Simon
> > 
> > > > > These patches add sh_clk_fsidiv_register() for FSI-DIV clock control.
> > > > > This is 1st step of FSI-DT support.
> > > > > My plan is...
> > > > > 
> > > > >  1st : sh/ARM: add FSI-DIV clock control functions
> > > > >  2nd : FSI driver supports audio clock calculation method
> > > > >  3rd : sh/ARM: remove old style .set_rate callback from platform
> > > > >  4th : FSI support DT
> > > > >  5th : platform use DT for FSI
> > > > > 
> > > > > Kuninori Morimoto (3):
> > > > >       sh: clkfwk: add sh_clk_fsidiv_register()
> > > > >       ARM: shmobile: sh7372: sh7372_fsidivX_clk become non-global
> > > > >       ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
> > > > 
> > > > I am slightly confused about why 4 patches, but its not a big deal.
> > > > 
> > > > Paul, how do you want to handle merging this?  The 1st patch looks like its
> > > > appropriate for your tree while the rest seem to belong in my tree. But I'm
> > > > happy for all the changes to go through one tree if that makes sense.
> > > 
> > > It's not such a big deal either way. Once the first patch has been
> > > corrected with the appropriate I/O accessors you're welcome to take it
> > > with the rest with my Acked-by. I don't believe we have anything on the
> > > SH side that depends on it, so there's not a lot of point in decoupling
> > > it from the rest of the patch set.
> > 
> > Now ALSA SoC maintainer accepted above 2nd step patch-set of FSI driver,
> > So, I would like to send 3rd step patches to SH-ML.
> > But it needs above (1st step) patch-set.
> > Where can I find ?
> 
> Hi Morimoto-san,
> 
> sorry for being a bit slow. There seem to be four patches in this series:
> 
> [PATCH 1/3] sh: clkfwk: add sh_clk_fsidiv_register()
> [PATCH 2/3] ARM: shmobile: sh7372: sh7372_fsidivX_clk become non-global
> [PATCH 3/3] ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
> [PATCH 4/3] ARM: shmobile: r8a7740: add FSI-DVI clocks
> 
> 
> It seems that the first patch for drivers/sh/clk/cpg.c and
> include/linux/sh_clk.h and thus would normally go through Paul's tree.
> And that it is a dependency of the other three patches.
> 
> Paul, I wonder if it would be easiest to try and push all of these changes
> through my tree.
> 
Yes, it's fine going through your tree. You can add my acked-by if you
wish.
