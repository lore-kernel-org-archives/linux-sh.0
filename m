From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Nov 2013 00:16:50 +0000
Subject: Re: [PATCH 00/10] Lager multiplatform support
Message-Id: <20131101001650.GD6818@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383059082-26315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383059082-26315-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 31, 2013 at 01:24:28PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 31 October 2013 14:27:47 Simon Horman wrote:
> > On Tue, Oct 29, 2013 at 04:04:32PM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch set moves the lager-reference board over to multiplatform
> > > kernel. It starts by syncing the Lager DTS with the Lager reference DTS
> > > (01/10), instantiates clocks in DT using the R8A7790 CCF drivers
> > > previously posted (02/10 to 04/10), switches lager-reference over to
> > > multiplatform (05/10 to 06/10) and cleans up unneeded leftovers (07/10 to
> > > 10/10).
> > > 
> > > The net result is a multiplatform-only lager-reference board with a single
> > > DTS shared by the lager and lager-reference boards.
> > > 
> > > The code is available in my git tree at
> > > 
> > >         git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/lager
> > > 
> > > The branch is based on a merge of renesas-devel-20131016, v3.12-rc7 and
> > > multiarch drivers, clk-prepare and r8a7790 CCF patches I've posted earlier
> > > today.
> > 
> > Thanks Laurent.
> > 
> > I would like to ask you to re-post these patches once the required
> > dependencies have been merged.
> 
> Sure.
> 
> > I will also need a stable branch or branches on which to base any
> > application of these changes.
> 
> That will be the hard part :-) some of the patches should get merged in v3.13-
> rc1. I'll try to request stable branches for the others.

Yes, that will be the hard part :-)
