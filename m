From: Simon Horman <horms@verge.net.au>
Date: Thu, 10 Oct 2013 11:33:16 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: bockw: MMCIF support on DT
Message-Id: <20131010113312.GA18723@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878uy9259u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uy9259u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 09, 2013 at 10:20:46PM +0200, Laurent Pinchart wrote:
> Hi Morimoto-san and Simon,
> 
> On Tuesday 08 October 2013 17:11:10 Kuninori Morimoto wrote:
> > Hi Simon, Laurent
> > 
> > > > Laurent, could you let me know if you have a branch available with "ARM:
> > > > shmobile: r8a7778: Fix pin control device address in DT". If not I'm
> > > > happy
> > > > to wait.
> > > 
> > > I don't have one. The bug got introduced in v3.12-rc1, without any serious
> > > consequence as the DT node wasn't used. The fix might even break the
> > > bockw-
> > > reference board if Morimoto-san's patch 4 isn't applied, as the PFC device
> > > seems to be registered twice then (I haven't tested this).
> > > 
> > > Morimoto-san, could you please test my fix on bockw-reference without your
> > > patch series ? If it doesn't break anything then we could push it to
> > > v3.12.
> > > Otherwise we can include it with this series. Simon, would that be fine
> > > with you ?
> > 
> > I tested Laurent's fixup patch on
> > 
> >  - latest linus/master    + fixup patch
> >  - renesas-devel-20131008 + fixup patch
> > 
> > both works well
> 
> Thank you for testing this.
> 
> Simon, would you like to pick up the patch for v3.12 ?

Hi Laurent, Hi Morimoto,

sorry for the confusion and delay.

Yes I can take that patch but as its not urgent I would prefer
to queue it up for v3.13 or at this stage more likely the distant v3.14.
