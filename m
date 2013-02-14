From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 00:59:08 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: fix kzm9g-reference compile breakage
Message-Id: <20130214005908.GH15879@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1302121535330.7059@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1302121535330.7059@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 05:16:36PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 13 February 2013 11:31:19 Simon Horman wrote:
> > On Tue, Feb 12, 2013 at 03:55:55PM +0100, Guennadi Liakhovetski wrote:
> > > Recently many pin function names have been removed, as their users have
> > > been switched to use pinctrl. However, kzm9g-reference has been left
> > > unchanged, which broke its compilation. Fix this by switching over to
> > > pinctrl.
> > 
> > Thanks.
> > 
> > I'm rather unsure what to do about this.
> > 
> > On the one hand I would rather if the basic kzm9g-reference code didn't
> > depend on any more pinmux changes to allow it to flow upstream sooner than
> > later.
> > 
> > On the other hand things are clearly broken without some modifications to
> > the kzm9g-reference code to accomodate the pinmux changes.
> 
> Given that only two small patches are needed to fix the issue, I believe we 
> could sort this out in a "first come, first served" way. If the kzm9g-
> reference branch gets ready for mainline before my remaining pinctrl changes, 
> you can push it as-is, and I'll take the two patches listed below in my tree. 
> If the timeline is shifted the other way around, you will just need to take 
> the two patches in your tree.
> 
> Would that work for you ?

Yes, I think so.
