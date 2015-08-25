From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 25 Aug 2015 07:15:16 +0000
Subject: Re: [PATCH] drm: rcar-du: Fix plane state free in plane reset handler
Message-Id: <20150825071516.GI20434@phenom.ffwll.local>
List-Id: <linux-sh.vger.kernel.org>
References: <1438820580-14301-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1768630.dTmQoR56Ge@avalon>
 <20150814073015.GG17734@phenom.ffwll.local>
 <19460030.7jS9GcTr8h@avalon>
In-Reply-To: <19460030.7jS9GcTr8h@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>

On Tue, Aug 18, 2015 at 09:35:44AM +0300, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Friday 14 August 2015 09:30:15 Daniel Vetter wrote:
> > On Fri, Aug 14, 2015 at 12:19:03AM +0300, Laurent Pinchart wrote:
> > > On Friday 07 August 2015 17:30:08 Laurent Pinchart wrote:
> > > > On Friday 07 August 2015 14:53:22 Thierry Reding wrote:
> > > > > On Thu, Aug 06, 2015 at 03:23:00AM +0300, Laurent Pinchart wrote:
> > > > > > The plane reset handler frees the plane state and allocates a new
> > > > > > default state, but when doing so attempt to free the plane state
> > > > > > using the base plane state pointer instead of casting it to the
> > > > > > driver-specific state object that has been allocated. Fix it by
> > > > > > using the rcar_du_plane_atomic_destroy_state() function to destroy
> > > > > > the plane state instead of duplicating the code.
> > > > > > 
> > > > > > Signed-off-by: Laurent Pinchart
> > > > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > > > ---
> > > > > > 
> > > > > >  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 45 ++++++++++------------
> > > > > >  1 file changed, 22 insertions(+), 23 deletions(-)
> > > > > > 
> > > > > > Should the DRM core free the atomic state before calling the reset
> > > > > > operation ? That would simplify drivers.
> > > > > 
> > > > > The core can't do that because drivers might have subclassed the
> > > > > state.
> > > > 
> > > > But the core can call the .atomic_destroy_state() operation, can't it ?
> > > 
> > > Thierry, Daniel, any comment on this ?
> > 
> > Doesn't really help you since the kzalloc is still in the helper. Btw this
> > is all helper code, core won't do here anything at all ;-)
> 
> Is it ? The .reset() and .atomic_destroy_state() are core plane operations, 
> not helper operations.

Reset not being a helper func is an accident of history I think, it should
be moved.

> My point is that, as .reset() needs to allocate the state if no state exists, 
> I'm wondering whether it wouldn't be simpler for drivers to free the state in 
> the core using .atomic_destroy_state() before calling .reset() and always 
> allocate a state in the driver's .reset() implementation.
> 
> In peudo-code, drivers currently do (or at least should do)
> 
> atomic_destroy_state(state)
> {
> 	driver_state = cast_to_driver_state(state);
> 
> 	clean up driver_state;
> 	kfree(driver_state);
> }
> 
> reset()
> {
> 	if (state) {
> 		driver_state = cast_to_driver_state(state);
> 
> 		clean up driver_state;

Why not call destroy_state here and make the kzalloc unconditional?
Simpler and with that not much point in removing copypasting ...

> 	} else {
> 		driver_state = kzalloc(...);
> 	}
> 
> 	set all fields of driver_state to default values;
> }
> 
> Wouldn't it be simpler to have the core call .atomic_destroy_state() before 
> .reset() and implement .reset() as
> 
> reset()
> 	driver_state = kzalloc(...);
> 
> 	set all fields of driver_state to default values;
> }
> 
> ?

Well all the reset stuff was pretty much stop-gap, ->reset really
shouldn't be a core op. What I eventually wanted to do is lift the hw
state readout logic from i915 as the proper way to do this, since without
this you can't do fastboot. Eric is interested in fastboot for vc4, so we
discussed this a bit at lpc.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
