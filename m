From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 13 Aug 2015 21:19:03 +0000
Subject: Re: [PATCH] drm: rcar-du: Fix plane state free in plane reset handler
Message-Id: <1768630.dTmQoR56Ge@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1438820580-14301-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20150807125321.GE25792@ulmo> <2325494.jkNV16dCnQ@avalon>
In-Reply-To: <2325494.jkNV16dCnQ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

On Friday 07 August 2015 17:30:08 Laurent Pinchart wrote:
> On Friday 07 August 2015 14:53:22 Thierry Reding wrote:
> > On Thu, Aug 06, 2015 at 03:23:00AM +0300, Laurent Pinchart wrote:
> > > The plane reset handler frees the plane state and allocates a new
> > > default state, but when doing so attempt to free the plane state using
> > > the base plane state pointer instead of casting it to the
> > > driver-specific state object that has been allocated. Fix it by using
> > > the rcar_du_plane_atomic_destroy_state() function to destroy the plane
> > > state instead of duplicating the code.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 45 ++++++++++++--------------
> > >  1 file changed, 22 insertions(+), 23 deletions(-)
> > > 
> > > Should the DRM core free the atomic state before calling the reset
> > > operation ? That would simplify drivers.
> > 
> > The core can't do that because drivers might have subclassed the state.
> 
> But the core can call the .atomic_destroy_state() operation, can't it ?

Thierry, Daniel, any comment on this ?

> > Reviewed-by: Thierry Reding <treding@nvidia.com>

-- 
Regards,

Laurent Pinchart

