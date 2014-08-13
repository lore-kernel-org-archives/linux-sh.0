From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Aug 2014 23:41:27 +0000
Subject: Re: [PATCH v2 7/8] ARM: shmobile: r8a7790: Add DMAC devices to DT
Message-Id: <20140813234127.GB13100@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1405727425-6237-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405727425-6237-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 13, 2014 at 03:20:04PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Aug 8, 2014 at 4:19 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Sat, Jul 19, 2014 at 01:50:24AM +0200, Laurent Pinchart wrote:
> >> Instantiate the two system DMA controllers in the r8a7790 device tree.
> >>
> >> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> > Thanks. As the bindings have been merged I have queued up this patch for
> > v3.18.
> 
> It seems you forgot to apply "[PATCH v2 6/8] ARM: shmobile: r8a7790: Add
> DMAC clocks to DT", which adds the clocks that are used by "[PATCH v2 7/8]
> ARM: shmobile: r8a7790: Add DMAC devices to DT".
> 
> As these clocks are referenced by (symbolic define for a) number, not a
> phandle, you don't get an error from dtc.

Thanks, I'll look into that.
