From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Apr 2013 15:30:03 +0000
Subject: Re: [PATCH] ARM: shmobile: marzen-reference: use irqpin for lan
Message-Id: <20130409153003.GA13831@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365125960-25753-1-git-send-email-horms+renesas@verge.net.au>
 <20130409125256.GG15412@verge.net.au>
In-Reply-To: <20130409125256.GG15412@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Apr 09, 2013 at 09:52:56PM +0900, Simon Horman wrote:
> On Fri, Apr 05, 2013 at 10:39:20AM +0900, Simon Horman wrote:
> > This corrects the configuration of the SMSC lan controller
> > to use the newly added irqpin as its IRQ source.
> > 
> > Previously the lan controller did not work. Now it does.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Queued up in the boards-marzen branch.

Dropped as the pre-requisite irqpin dt code isn't queued-up yet.
