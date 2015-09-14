From: Daniel Vetter <daniel@ffwll.ch>
Date: Mon, 14 Sep 2015 07:22:13 +0000
Subject: Re: [PATCH 08/22] drm: rcar-du: Restart the DU group when a plane source changes
Message-Id: <20150914072213.GC3383@phenom.ffwll.local>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1442184669-30990-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

On Mon, Sep 14, 2015 at 01:50:55AM +0300, Laurent Pinchart wrote:
> Plane sources are configured by the VSPS bit in the PnDDCR4 register.
> Although the datasheet states that the bit is updated during vertical
> blanking, it seems that updates only occur when the DU group is held in
> reset through the DSYSR.DRES bit. Restart the group if the source
> changes.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_crtc.c  |  4 ++++
>  drivers/gpu/drm/rcar-du/rcar_du_group.c |  2 ++
>  drivers/gpu/drm/rcar-du/rcar_du_group.h |  2 ++
>  drivers/gpu/drm/rcar-du/rcar_du_plane.c | 22 ++++++++++++++++++++--
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> index 48cb19949ca3..7e2f5c26d589 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> @@ -272,6 +272,10 @@ static void rcar_du_crtc_update_planes(struct rcar_du_crtc *rcrtc)
>  			rcar_du_group_restart(rcrtc->group);
>  	}
>  
> +	/* Restart the group if plane sources have changed. */
> +	if (rcrtc->group->need_restart)
> +		rcar_du_group_restart(rcrtc->group);
> +
>  	mutex_unlock(&rcrtc->group->lock);
>  
>  	rcar_du_group_write(rcrtc->group, rcrtc->index % 2 ? DS2PR : DS1PR,
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.c b/drivers/gpu/drm/rcar-du/rcar_du_group.c
> index 4a44ddd51766..0e2b46dce563 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_group.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.c
> @@ -162,6 +162,8 @@ void rcar_du_group_start_stop(struct rcar_du_group *rgrp, bool start)
>  
>  void rcar_du_group_restart(struct rcar_du_group *rgrp)
>  {
> +	rgrp->need_restart = false;
> +
>  	__rcar_du_group_start_stop(rgrp, false);
>  	__rcar_du_group_start_stop(rgrp, true);
>  }
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_group.h b/drivers/gpu/drm/rcar-du/rcar_du_group.h
> index 4b1952fd4e7d..5e3adc6b31b5 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_group.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_group.h
> @@ -32,6 +32,7 @@ struct rcar_du_device;
>   * @dptsr_planes: bitmask of planes driven by dot-clock and timing generator 1
>   * @num_planes: number of planes in the group
>   * @planes: planes handled by the group
> + * @need_restart: the group needs to be restarted due to a configuration change
>   */
>  struct rcar_du_group {
>  	struct rcar_du_device *dev;
> @@ -47,6 +48,7 @@ struct rcar_du_group {
>  
>  	unsigned int num_planes;
>  	struct rcar_du_plane planes[RCAR_DU_NUM_KMS_PLANES];
> +	bool need_restart;

My recommendation is to keep any of these intermediate values in state
objects too. The reason is that eventually we want to also support real
queues of atomic commits, and then anything stored globally (well, outside
of the state objects) won't work. And yes it's ok to push that kind of
stuff into helper, this isn't really any different than e.g.
crtc_state->active_changed and similar booleans indicating that something
special needs to be done when committing.

Cheers, Daniel

>  };
>  
>  u32 rcar_du_group_read(struct rcar_du_group *rgrp, u32 reg);
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> index 78ca353bfcf0..c7e0535c0e77 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> @@ -275,9 +275,27 @@ static void rcar_du_plane_atomic_update(struct drm_plane *plane,
>  					struct drm_plane_state *old_state)
>  {
>  	struct rcar_du_plane *rplane = to_rcar_plane(plane);
> +	struct rcar_du_plane_state *old_rstate;
> +	struct rcar_du_plane_state *new_rstate;
>  
> -	if (plane->state->crtc)
> -		rcar_du_plane_setup(rplane);
> +	if (!plane->state->crtc)
> +		return;
> +
> +	rcar_du_plane_setup(rplane);
> +
> +	/* Check whether the source has changed from memory to live source or
> +	 * from live source to memory. The source has been configured by the
> +	 * VSPS bit in the PnDDCR4 register. Although the datasheet states that
> +	 * the bit is updated during vertical blanking, it seems that updates
> +	 * only occur when the DU group is held in reset through the DSYSR.DRES
> +	 * bit. We thus need to restart the group if the source changes.
> +	 */
> +	old_rstate = to_rcar_plane_state(old_state);
> +	new_rstate = to_rcar_plane_state(plane->state);
> +
> +	if ((old_rstate->source = RCAR_DU_PLANE_MEMORY) !> +	    (new_rstate->source = RCAR_DU_PLANE_MEMORY))
> +		rplane->group->need_restart = true;
>  }
>  
>  static const struct drm_plane_helper_funcs rcar_du_plane_helper_funcs = {
> -- 
> 2.4.6
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
