From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Apr 2013 03:11:37 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: use RCAR_GP_PIN() on _GP_GPIO() macro
Message-Id: <20130416031136.GC5490@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878v4sb8y1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v4sb8y1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 10, 2013 at 09:40:41AM +0900, Simon Horman wrote:
> On Tue, Apr 09, 2013 at 07:07:40PM +0200, Laurent Pinchart wrote:
> > Hi Morimoto-san,
> > 
> > On Monday 08 April 2013 21:54:18 Kuninori Morimoto wrote:
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > 
> > > >> Laurent
> > > 
> > > I guess this patch is correct on your macro idea ?
> > 
> > Yes it is.
> > 
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Thanks. I'll apply this on top of your series if
> it gets a positive review from Magnus.

I have queued up this patch for v3.11 in the soc-r8a7779 branch.
