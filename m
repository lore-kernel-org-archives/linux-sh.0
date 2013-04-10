From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 04:48:04 +0000
Subject: Re: [RFC][PATCH 3/4] ARM: shmobile: r8a7778: Register PFC drivce
Message-Id: <20130410044802.GC10044@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738v0b73z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738v0b73z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 07:26:01PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > On Wed, Apr 10, 2013 at 11:17:57AM +0900, Simon Horman wrote:
> > > On Tue, Apr 09, 2013 at 04:24:19PM +0200, Laurent Pinchart wrote:
> > > > Hi Morimoto-san,
> > > > 
> > > > Thank you for the patch.
> > > > 
> > > > On Monday 08 April 2013 22:33:56 Kuninori Morimoto wrote:
> > > > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > > 
> > > > With the drivce replaced by device in the subject line,
> > > > 
> > > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > Thanks, I have queued this up in the soc-r7a7778 branch with the subject
> > > corrected.
> > 
> > Actually, scratch that.
> > There is a run-time dependency on an earlier patch in the series, right?
> 
> This patch depends on [1/x] patch, and I will send v2 patch today

Thanks, understood.

Could you note that in the changelog, perhaps under a "---"?
It might help me to avoid the same mistake a second time.
