From: Simon Horman <horms@verge.net.au>
Date: Thu, 14 Feb 2013 00:40:13 +0000
Subject: Re: [PATCH 2/3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <20130214004012.GE15879@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1359596703-17556-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130213122820.GA19512@verge.net.au>
 <1952026.K0AL5gJOGS@avalon>
In-Reply-To: <1952026.K0AL5gJOGS@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com

On Wed, Feb 13, 2013 at 07:18:33PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 13 February 2013 21:28:20 Simon Horman wrote:
> > On Thu, Jan 31, 2013 at 02:45:02AM +0100, Laurent Pinchart wrote:
> > > The R-Car Display Unit (DU) DRM driver supports both superposition
> > > processors and all eight planes in RGB and YUV formats without alpha
> > > blending.
> > > 
> > > Only VGA and LVDS encoders and connectors are currently supported.
> > 
> > As discussed elsewhere I have applied this series to topic/r-car-du-drm
> > in the renesas tree.
> > 
> > Subsequently, thanks to the wonder that is kbuild,
> > I have noticed the following build error when using this series
> > in conjunction with "ARM: shmobile: r8a7779: Remove DU function GPIOs".
> > 
> > Clearly this will not be a problem if this series is applied before
> > the patch above. But presumably it will be a problem down the road.
> > And actually it is currently a (ignorable) problem in topic/all+next.
> > 
> > In any case, I was wondering if Laurent could cook up an add-on patch
> > to resolve this problem. At the very least it would provide a
> > reference for how to solve the problem later on and as a bonus clean
> > up topic/all+next.
> 
> The DU board code I've submitted for the Marzen board doesn't use the pinctrl 
> API yet, as I wanted the DU DRM driver to be usable without waiting for the 
> next pinctrl series to be ready. I will fix this later, either in the DU DRM 
> driver patch series or in the pinctrl patch series, depending on which one is 
> ready first.
> 
> In the meantime, please keep the branches separate.

Sure, I can do that :)
