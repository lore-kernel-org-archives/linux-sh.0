From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 08:10:11 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: Remove legacy mach/irqs.h
Message-Id: <20150911081010.GC2835@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <074e25ac68b40603345a257504de0f4a125326e7.1392961497.git.horms+renesas@verge.net.au>
In-Reply-To: <074e25ac68b40603345a257504de0f4a125326e7.1392961497.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 11, 2015 at 10:39:22AM +0300, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Friday 11 September 2015 09:57:22 Simon Horman wrote:
> > On Sat, Aug 29, 2015 at 12:37:16AM +0300, Laurent Pinchart wrote:
> > > The header isn't needed anymore now that all SoCs use multiplatform
> > > kernels. Remove it.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Thanks, I have queued this up for v4.4.
> > 
> > N.B: I am not planning to take patch one of this series at this time.
> 
> Doesn't patch 2/3 depend on patch 1/3 ?

Thanks, I will drop patch 2.
Should I also drop patch 3?
