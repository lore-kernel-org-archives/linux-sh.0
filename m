From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Nov 2013 00:18:14 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: wait for MSTP clock status to toggle, when enabling it
Message-Id: <20131101001813.GF6818@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383066834-25956-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383066834-25956-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 31, 2013 at 01:34:04PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 31 October 2013 14:34:48 Simon Horman wrote:
> > On Tue, Oct 29, 2013 at 06:13:53PM +0100, Laurent Pinchart wrote:
> > > From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > 
> > > On r-/sh-mobile SoCs MSTP clocks are used by the runtime PM to dynamically
> > > enable and disable peripheral clocks. To make sure the clock has really
> > > started we have to read back its status register until it confirms
> > > success.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Is there an impact of this patch on shmobile, that is ARM SoCs or boards
> > based on them?
> 
> There's no impact on existing SoCs or boards, as this patch adds support for a 
> feature that is turned on by default. SoCs need to explicitly enable it when 
> declaring the MSTP clocks to get any behaviour change.

Ok. Is there a plan to make use of this on the shmobile (ARM) side?
