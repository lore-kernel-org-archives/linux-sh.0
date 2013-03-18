From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Mar 2013 12:08:12 +0000
Subject: Re: [PATCH 43/43] ARM: shmobile: fix kzm9g-reference compile breakage
Message-Id: <20130318120808.GA24552@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
 <1363607255-6385-44-git-send-email-horms+renesas@verge.net.au>
 <Pine.LNX.4.64.1303181258080.30957@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1303181258080.30957@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Mar 18, 2013 at 12:58:49PM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Mon, 18 Mar 2013, Simon Horman wrote:
> 
> > From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > Recently many pin function names have been removed, as their users have
> > been switched to use pinctrl. However, kzm9g-reference has been left
> > unchanged, which broke its compilation. Fix this by switching over to
> > pinctrl.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> I think, there's a problem with this one. The description doesn't match 
> the body, this isn't my patch.

Thanks, I'll investigate.
