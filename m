From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 15:58:46 +0000
Subject: Re: [PATCH/RFC 2/3] pinctrl: sh-pfc: add pin groups for all SD/MMC interfaces on sh73a0
Message-Id: <20130214155846.GB26810@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 12:11:18PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 14 February 2013 09:39:28 Simon Horman wrote:
> > On Wed, Feb 13, 2013 at 07:07:20PM +0100, Laurent Pinchart wrote:
> > > Hi Guennadi,
> > > 
> > > Thanks for the patch.
> > > 
> > > On Tuesday 12 February 2013 16:50:03 Guennadi Liakhovetski wrote:
> > > > Add pin group definitions for SDHI0, SDHI1, SDHI2 and MMCIF interfaces
> > > > on sh73a0.
> > > > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > 
> > > As this patch doesn't strictly depend on 1/3 I've taken it in my tree. I
> > > will push it along with a sparse GPIO numbering fix (I'm currently
> > > reviewing 1/3).
> >
> > Thanks. To clarify that will go via Linus's tree?
> 
> Once again this patch series will touch both arch/arm/mach-shmobile and 
> drivers/pinctrl/sh-pfc. There will likely be less chances of conflicts if it 
> goes through your tree.

Understood.
