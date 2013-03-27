From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Mar 2013 11:01:54 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: marzen: defconfig updates for v3.10
Message-Id: <20130327110154.GI413@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364356017-25890-1-git-send-email-horms+renesas@verge.net.au>
 <2124307.JaW9GEbPEK@avalon>
In-Reply-To: <2124307.JaW9GEbPEK@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Mar 27, 2013 at 09:34:50AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thanks for the patches.
> 
> On Wednesday 27 March 2013 12:46:55 Simon Horman wrote:
> > Hi,
> > 
> > the this short series updates the defconfig for marzen for changes
> > made by the following patches which I plan to queue-up for v3.10 shortly.
> > 
> > 1. ARM: shmobile: marzen: Add GPIO LEDs
> > 2. gpio: Renesas R-Car GPIO driver V3
> > 
> > The patches in this series are:
> > 
> > Simon Horman (2):
> >   ARM: shmobile: marzen: defconfig: add GPIO RCAR driver support
> >   ARM: shmobile: marzen: defconfig: enable GPIO LEDs driver
> > 
> >  arch/arm/configs/marzen_defconfig |    4 ++++
> >  1 file changed, 4 insertions(+)
> 
> For the whole series,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I will add them to the defconfig branch with your Ack.
