From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Dec 2014 00:11:25 +0000
Subject: Re: [PATCH] ARM: shmobile: ape6evm: Fix LAN9220 VDDVARIO voltage
Message-Id: <20141219001125.GC29188@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418771845-12191-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418771845-12191-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 18, 2014 at 04:30:12AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 18 December 2014 09:43:56 Simon Horman wrote:
> > On Wed, Dec 17, 2014 at 02:30:08AM +0200, Laurent Pinchart wrote:
> > > On Wednesday 17 December 2014 09:26:55 Simon Horman wrote:
> > > > On Wed, Dec 17, 2014 at 01:17:25AM +0200, Laurent Pinchart wrote:
> > > > > The LAN9220 VDDVARIO supply is powered by a 1.8V source, not 3.3V. Fix
> > > > > it in the device tree.
> > > > > 
> > > > > Signed-off-by: Laurent Pinchart
> > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > ---
> > > > > 
> > > > >  arch/arm/boot/dts/r8a73a4-ape6evm.dts | 14 +++++++++++---
> > > > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > > > 
> > > > > This patch is based on top of Ulrich's "[PATCH v2 0/7] ARM: shmobile:
> > > > > ape6evm: multiplatform support" series, but it could easily be rebased
> > > > > to apply without that dependency.
> > > > 
> > > > My preference is to take this fix before Ulrich's series.
> > > > But I am happy to negotiate if others have a different preference.
> > > 
> > > Just for the record I have no preference given that this fix doesn't have
> > > any influence on the system.
> > 
> > Thanks, in that case I don't feel strongly about it either.
> > But lets try not to let it slip through the cracks.
> 
> Given that you've just merged the dependencies I think you can merge this 
> patch :-)

Indeed, done :)
