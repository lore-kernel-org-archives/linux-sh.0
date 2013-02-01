From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Feb 2013 03:26:41 +0000
Subject: Re: [PATCH 0/3] R-Car Display Unit DRM driver
Message-Id: <20130201032641.GC15639@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130131063838.GC24518@verge.net.au>
 <226620406.loYPPLmWhQ@avalon>
In-Reply-To: <226620406.loYPPLmWhQ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com

On Fri, Feb 01, 2013 at 04:15:31AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 31 January 2013 15:38:38 Simon Horman wrote:
> > On Thu, Jan 31, 2013 at 02:45:00AM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > Here's a new DRM driver for the Renesas R-Car Display Unit (DU).
> > > 
> > > The DU features two superposition processors (modeled as CRTCs) and eight
> > > planes that can be shared between the superposition processors.
> > > 
> > > The driver supports the superposition processors (currently in pure
> > > overlay mode without alpha blending), all eight planes and all hardware
> > > supported formats except 8-bit indexed color more and 32-bit RGB666 mode
> > > (that would be [31:0] x:R:x:G:x:B:x 8:6:2:6:2:6:2 little endian, not
> > > supported by DRM at the moment).
> > > 
> > > On the output side only sync master non-interlaced modes are currently
> > > supported. Only the VGA output has been tested, as I lack an LVDS panel
> > > for the development board. The second CRTC hasn't been tested for the same
> > > reason.
> > > 
> > > Platform data are subject to change with the common display framework.
> > > This is why I haven't implemented DT bindings yet.
> > > 
> > > Laurent Pinchart (2):
> > >   drm: Renesas R-Car Display Unit DRM driver
> > >   ARM: shmobile: marzen: Add Display Unit support
> > 
> > I assume that the above patch is dependent on the other two patches in the
> > series. If so please let me know how you would like to handle the merge.
> 
> It would probably easier to push everything through your tree, as the only 
> risk of conflict in the DRM patch is in Kconfig/Makefile. I'll first give time 
> to reviewers anway.

That is fine by me.
