From: Daniel Vetter <daniel@ffwll.ch>
Date: Thu, 17 Dec 2015 09:41:51 +0000
Subject: Re: [PATCH 08/22] drm: rcar-du: Restart the DU group when a plane source changes
Message-Id: <20151217094151.GV30437@phenom.ffwll.local>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1442184669-30990-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20150914072213.GC3383@phenom.ffwll.local>
 <2986707.83nd5NsHMZ@avalon>
In-Reply-To: <2986707.83nd5NsHMZ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

On Thu, Dec 17, 2015 at 09:11:49AM +0200, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Monday 14 September 2015 09:22:13 Daniel Vetter wrote:
> > On Mon, Sep 14, 2015 at 01:50:55AM +0300, Laurent Pinchart wrote:
> > > Plane sources are configured by the VSPS bit in the PnDDCR4 register.
> > > Although the datasheet states that the bit is updated during vertical
> > > blanking, it seems that updates only occur when the DU group is held in
> > > reset through the DSYSR.DRES bit. Restart the group if the source
> > > changes.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  4 ++++
> > >  drivers/gpu/drm/rcar-du/rcar_du_group.c |  2 ++
> > >  drivers/gpu/drm/rcar-du/rcar_du_group.h |  2 ++
> > >  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 22 ++++++++++++++++++++--
> > >  4 files changed, 28 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > > b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c index 48cb19949ca3..7e2f5c26d589
> > > 100644
> > > --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > > +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > > @@ -272,6 +272,10 @@ static void rcar_du_crtc_update_planes(struct
> > > rcar_du_crtc *rcrtc)
> > >  			rcar_du_group_restart(rcrtc->group);
> > >  	}
> > > 
> > > +	/* Restart the group if plane sources have changed. */
> > > +	if (rcrtc->group->need_restart)
> > > +		rcar_du_group_restart(rcrtc->group);
> > > +
> > >  	mutex_unlock(&rcrtc->group->lock);
> > >  	
> > >  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR,
> > > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c
> > > b/drivers/gpu/drm/rcar-du/rcar_du_group.c index
> > > 4a44ddd51766..0e2b46dce563 100644
> > > --- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
> > > +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
> > > @@ -162,6 +162,8 @@ void rcar_du_group_start_stop(struct rcar_du_group
> > > *rgrp, bool start)
> > > 
> > >  void rcar_du_group_restart(struct rcar_du_group *rgrp)
> > >  {
> > > +	rgrp->need_restart = false;
> > > +
> > >  	__rcar_du_group_start_stop(rgrp, false);
> > >  	__rcar_du_group_start_stop(rgrp, true);
> > >  }
> > > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h
> > > b/drivers/gpu/drm/rcar-du/rcar_du_group.h index
> > > 4b1952fd4e7d..5e3adc6b31b5 100644
> > > --- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
> > > +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
> > > @@ -32,6 +32,7 @@ struct rcar_du_device;
> > >   * @dptsr_planes: bitmask of planes driven by dot-clock and timing
> > >   generator 1
> > >   * @num_planes: number of planes in the group
> > >   * @planes: planes handled by the group
> > > + * @need_restart: the group needs to be restarted due to a configuration
> > > change
> > >   */
> > >  struct rcar_du_group {
> > >  	struct rcar_du_device *dev;
> > > @@ -47,6 +48,7 @@ struct rcar_du_group {
> > >  	unsigned int num_planes;
> > >  	struct rcar_du_plane planes[RCAR_DU_NUM_KMS_PLANES];
> > > 
> > > +	bool need_restart;
> > 
> > My recommendation is to keep any of these intermediate values in state
> > objects too. The reason is that eventually we want to also support real
> > queues of atomic commits,
> 
> I like the idea :-)
> 
> > and then anything stored globally (well, outside of the state objects) won't
> > work. And yes it's ok to push that kind of stuff into helper, this isn't
> > really any different than e.g. crtc_state->active_changed and similar
> > booleans indicating that something special needs to be done when committing.
> 
> I agree with you. There's still a couple of state variables I need to remove 
> in the driver structures, and that's on my todo list (although not very high 
> I'm afraid).
> 
> The group state is a bit of an oddball. The DU groups CRTCs by two and shares 
> resources inside a group. Implementing that resource sharing requires storing 
> group state, which is very difficult without an atomic state object for the 
> group.
> 
> Am I missing an easy way to fix that ? And would it be fine to upstream this 
> patch as-is in the meantime ? I'd like to get it in v4.6, it's been out for 
> long enough and is blocking other people.

Involves a bit of typing, but we allow drivers to subclass
drm_atomic_state and add whatever they want. The important part is to make
sure you get the locking right, i.e. only ever duplicate anything when you
hold the right locks. For that you have about 3 options:
- protect all group state with mode_config->connection_lock. Might
  unecessarily serialize updates.
- create a per-group ww_mutex (atomic allows you to throw as many
  additional ww_mutex locks encapsulated within a drm_modeset_lock as you
  want).
- just grab the crtc states (plus locks) for all the crtcs in a group when
  duplicating a group state

I highly recommend you follow the patterns laid out in drm_atomic.c and
only allow your driver to get at the group state through a get_group_state
helper, like we have for plane/crtc/connector states. That can then take
care of the locking and everything.

i915 uses this to keep track of shared resources like dpll and display
core clock.

There should be kerneldoc for the individual functions, but I think we
lack an overview/example section ... hint, hint ;-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
