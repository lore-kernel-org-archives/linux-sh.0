From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Mar 2013 01:03:14 +0000
Subject: Re: [PATCH v2] sh-pfc: r8a73a4: Add IRQC pin groups and functions
Message-Id: <20130328010314.GL20736@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <5327461.n5dWakeRbN@avalon>
In-Reply-To: <5327461.n5dWakeRbN@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 28, 2013 at 01:41:36AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 28 March 2013 09:26:51 Simon Horman wrote:
> > On Wed, Mar 27, 2013 at 04:13:42PM +0100, Laurent Pinchart wrote:
> > > Hi Magnus,
> > > 
> > > Thanks for the patch.
> > > 
> > > On Thursday 28 March 2013 00:16:37 Magnus Damm wrote:
> > > > From: Magnus Damm <damm@opensource.se>
> > > > 
> > > > V2 of PINCTRL support for r8a73a4 IRQC hardware
> > > > and in particular the external pins IRQ0 -> IRQ57.
> > > > 
> > > > Signed-off-by: Magnus Damm <damm@opensource.se>
> > > 
> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Laurent, I am assuming you will add this to your tree and
> > let me know where to pull from. If not, I can take it directly.
> 
> You can get the patches from the pinmux/3.9/r8a73a4 branch in my git tree.

Thanks, I have cherry-picked them into my local pinmux branch and
will push shortly.

BTW, the way you mange your git tree saves me lots of time. Thanks.
