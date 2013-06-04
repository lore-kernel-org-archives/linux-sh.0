From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 04 Jun 2013 18:03:19 +0000
Subject: Re: [PATCH v3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <1463323.zSQmk3Du5c@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1370314420-26524-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130604141236.GC15743@phenom.ffwll.local>
In-Reply-To: <20130604141236.GC15743@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Daniel,

On Tuesday 04 June 2013 16:12:36 Daniel Vetter wrote:
> On Tue, Jun 04, 2013 at 04:53:40AM +0200, Laurent Pinchart wrote:
> > The R-Car Display Unit (DU) DRM driver supports both superposition
> > processors and all eight planes in RGB and YUV formats with alpha
> > blending.
> > 
> > Only VGA and LVDS encoders and connectors are currently supported.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Ok, I've done a little review, and the driver looks rather nice.

Thank you.

> With a simpler driver like this the drm boilerplate sticks out more, so I've
> dropped a few grumblings about that. But I've also spotted 3 little things
> which imo should be fixed before merging. Comments inline below.
> 
> Cheers, Daniel

[snip]

> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c new file mode 100644
> > index 0000000..c66fa4c
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c

[snip]

> > +static void rcar_du_start_stop(struct rcar_du_device *rcdu, bool start)
> > +{
> > +	/* Many of the configuration bits are only updated when the display
> > +	 * reset (DRES) bit in DSYSR is set to 1, disabling *both* CRTCs.
> > +	 * Some of those bits could be pre-configured, but others (especially
> > +	 * the bits related to plane assignment to display timing
> > +	 * controllers) need to be modified at runtime.
> > +	 *
> > +	 * Restart the display controller if a start is requested. Sorry for 
> > +	 * the flicker. It should be possible to move most of the "DRES-
> > +	 * update" bits setup to driver initialization time and minimize the
> > +	 * number of cases when the display controller will have to be
> > +	 * restarted.
> > +	 */
> > +	if (start) {
> > +		if (rcdu->used_crtcs++ != 0)
> > +			__rcar_du_start_stop(rcdu, false);
> > +		__rcar_du_start_stop(rcdu, true);
> > +	} else {
> > +		if (--rcdu->used_crtcs = 0)
> > +			__rcar_du_start_stop(rcdu, false);
> > +	}
> > +}
> 
> You seem to be a prime user for atomic modeset stuff ;-) Have you looked
> already a bit into sensible additions for the crtc helpers to make that
> possible? Maybe a global modeset_prepare/commit hook?

Not yet. That's somewhere in my to-do list, but it's growing too long :-( I 
need to finish CDF first.

[snip]

> > +static int rcar_du_crtc_mode_set(struct drm_crtc *crtc,
> > +				 struct drm_display_mode *mode,
> > +				 struct drm_display_mode *adjusted_mode,
> > +				 int x, int y,
> > +				 struct drm_framebuffer *old_fb)
> > +{
> > +	struct rcar_du_device *rcdu = crtc->dev->dev_private;
> > +	struct rcar_du_crtc *rcrtc = to_rcar_crtc(crtc);
> > +	const struct rcar_du_format_info *format;
> > +	int ret;
> > +
> > +	format = rcar_du_format_info(crtc->fb->pixel_format);
> > +	if (format = NULL) {
> > +		dev_dbg(rcdu->dev, "mode_set: unsupported format %08x\n",
> > +			crtc->fb->pixel_format);
> > +		ret = -EINVAL;
> > +		goto error;
> > +	}
> > +
> > +	ret = rcar_du_plane_reserve(rcrtc->plane, format);
> > +	if (ret < 0)
> > +		goto error;
> > +
> > +	rcrtc->plane->format = format;
> > +	rcrtc->plane->pitch = crtc->fb->pitches[0];
> > +
> > +	rcrtc->plane->src_x = x;
> > +	rcrtc->plane->src_y = y;
> > +	rcrtc->plane->width = mode->hdisplay;
> > +	rcrtc->plane->height = mode->vdisplay;
> > +
> > +	rcar_du_plane_compute_base(rcrtc->plane, crtc->fb);
> > +
> > +	rcrtc->outputs = 0;
> > +
> > +	return 0;
> > +
> > +error:
> > +	/* There's no rollback/abort operation to clean up in case of error. 
> > +	 * We thus need to release the reference to the DU acquired in
> > +	 * prepare() here.
> > +	 */
> 
> Should we add that to crtc helpers, instead of the current "just try to
> smash the old config on top of the ill-defined hw state after a failed
> modeset"?

It would probably make sense to add a rollback operation to undo the prepare 
operation, or maybe just a rollback/commit flag to the commit operation. We 
would still need to smash the old config back though, as the rollback 
operation shouldn't be expected to handle encoders and connectors.

While we're at it, shouldn't we make drivers report supported formats for the 
main frame buffer, like we do for planes ? That would allow catching format 
errors before calling the prepare operation.

> > +	rcar_du_put(rcdu);
> > +	return ret;
> > +}

[snip]

> > +static void rcar_du_crtc_finish_page_flip(struct rcar_du_crtc *rcrtc)
> > +{
> > +	struct drm_pending_vblank_event *event;
> > +	struct drm_device *dev = rcrtc->crtc.dev;
> > +	struct timeval vblanktime;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&dev->event_lock, flags);
> > +	event = rcrtc->event;
> > +	rcrtc->event = NULL;
> > +	spin_unlock_irqrestore(&dev->event_lock, flags);
> > +
> > +	if (event = NULL)
> > +		return;
> > +
> > +	event->event.sequence > > +		drm_vblank_count_and_time(dev, rcrtc->index, &vblanktime);
> > +	event->event.tv_sec = vblanktime.tv_sec;
> > +	event->event.tv_usec = vblanktime.tv_usec;
> > +
> > +	spin_lock_irqsave(&dev->event_lock, flags);
> > +	list_add_tail(&event->base.link, &event->base.file_priv->event_list);
> > +	wake_up_interruptible(&event->base.file_priv->event_wait);
> > +	spin_unlock_irqrestore(&dev->event_lock, flags);
> > +
> 
> This should use the drm_send_vblank_event helper.

What bothers me about drm_send_vblank_event() is that it calls 
drm_vblank_count_and_time() with the events lock unnecessarily held. I can 
live with that for now, I'll fix the driver to use the helper.

> > +	drm_vblank_put(dev, rcrtc->index);
> > +}

[snip]

> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_drv.c new file mode 100644
> > index 0000000..003b34e
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c

[snip]

> > +static void rcar_du_disable_vblank(struct drm_device *dev, int crtc)
> > +{
> > +	struct rcar_du_device *rcdu = dev->dev_private;
> > +
> > +	rcar_du_crtc_enable_vblank(&rcdu->crtcs[crtc], false);
> > +}
> 
> Blergh, I hate our legacy vblank code which forces kms driver to jump
> through int pipe -> struct drm_crtc * hoops.

How would you like to fix it ? :-)

[snip]

> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_kms.c new file mode 100644
> > index 0000000..9c63f39
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c

[snip]

> > +int rcar_du_modeset_init(struct rcar_du_device *rcdu)
> > +{
> > +	struct drm_device *dev = rcdu->ddev;
> > +	struct drm_encoder *encoder;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	drm_mode_config_init(rcdu->ddev);
> > +
> > +	rcdu->ddev->mode_config.min_width = 0;
> > +	rcdu->ddev->mode_config.min_height = 0;
> > +	rcdu->ddev->mode_config.max_width = 4095;
> > +	rcdu->ddev->mode_config.max_height = 2047;
> > +	rcdu->ddev->mode_config.funcs = &rcar_du_mode_config_funcs;
> > +
> > +	ret = rcar_du_plane_init(rcdu);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(rcdu->crtcs); ++i)
> > +		rcar_du_crtc_create(rcdu, i);
> > +
> > +	rcdu->used_crtcs = 0;
> > +	rcdu->num_crtcs = i;
> > +
> > +	for (i = 0; i < rcdu->pdata->num_encoders; ++i) {
> > +		const struct rcar_du_encoder_data *pdata > > +			&rcdu->pdata->encoders[i];
> > +
> > +		if (pdata->output >= ARRAY_SIZE(rcdu->crtcs)) {
> > +			dev_warn(rcdu->dev,
> > +				 "encoder %u references unexisting output %u,
 skipping\n",
> > +				 i, pdata->output);
> > +			continue;
> > +		}
> > +
> > +		switch (pdata->encoder) {
> > +		case RCAR_DU_ENCODER_VGA:
> > +			rcar_du_vga_init(rcdu, &pdata->u.vga, pdata->output);
> > +			break;
> > +
> > +		case RCAR_DU_ENCODER_LVDS:
> > +			rcar_du_lvds_init(rcdu, &pdata->u.lvds, pdata->output);
> > +			break;
> > +
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	/* Set the possible CRTCs and possible clones. All encoders can be
> > +	 * driven by the CRTC associated with the output they're connected
> > +	 * to, as well as by CRTC 0.
> > +	 */
> > +	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
> > +		struct rcar_du_encoder *renc = to_rcar_encoder(encoder);
> > +
> > +		encoder->possible_crtcs = (1 << 0) | (1 << renc->output);
> > +		encoder->possible_clones = 1 << 0;
> 
> This looks strange. It should at least include
> 
> > +		encoder->possible_clones = 1 << i;
> 
> where i counts encoders to say that you can clone itself (userspace might
> get confused, haven't checked how throughout the modeset ddx is). But it
> sounds like rcar can clone encoders pretty freely (as long as they're
> using crtc 0), so maybe you want to use something like drm/i915 does?

The device has two outputs, 0 and 1. Output 0 can be driven by CRTC 0 only, 
and output 1 can be driven by CRTC 0 or CRTC 1.

> We smash all cloneable encoders into one groub with a
> intel_encoder->cloneable flag and then allow cloning any cloneable encoder
> to any other cloneable encoder with intel_encoder_clones in
> intel_display.c
> 
> possible_clones is a bit a ill-defined part of the kms api, but I think we
> still should strive for consistency. Maybe the modesetting ddx should also
> grow a warning if the possible_clones mask doesn't make too much sense.

I haven't been able to find an authoritative source of documentation regarding 
whether the possible_clones field should include the encoder itself. That 
should definitely be documented, I can fix the driver accordingly.

> > +	}
> > +
> > +	ret = rcar_du_plane_register(rcdu);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	drm_kms_helper_poll_init(rcdu->ddev);
> > +
> > +	drm_helper_disable_unused_functions(rcdu->ddev);
> > +
> > +	return 0;
> > +}
> 
> Hm, no fbdev legacy support or do I miss something?

Not yet. It's scheduled for a future update, for v3.12.

[snip]

> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_plane.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_plane.c new file mode 100644
> > index 0000000..a65f81d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_plane.c

[snip]

> > +static int rcar_du_plane_set_property(struct drm_plane *plane,
> > +				      struct drm_property *property,
> > +				      uint64_t value)
> > +{
> > +	struct rcar_du_device *rcdu = plane->dev->dev_private;
> > +	struct rcar_du_plane *rplane = to_rcar_plane(plane);
> > +
> > +	if (property = rcdu->planes.alpha)
> > +		rcar_du_plane_set_alpha(rplane, value);
> > +	else if (property = rcdu->planes.colorkey)
> > +		rcar_du_plane_set_colorkey(rplane, value);
> > +	else if (property = rcdu->planes.zpos)
> > +		rcar_du_plane_set_zpos(rplane, value);
> > +	else
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> 
> All our set_property functions have the same ugly if-ladder, I guess we
> should look into reworking the interfaces so that the drm core can
> directly call into the relevant callback.
> 
> But that's certainly not something which needs to be fixed right away.

We have designed and implemented the control framework in V4L2 to solve the 
same issue. It turned out to be a pretty complex piece of code though.

> A slightly more important discussion imo is whether we should standardize
> plane/crtc properties a bit more. Personally I think we can wait a bit
> with that until we have more drivers and generic users ... Worst case we
> end up with a bit of backwards compat cruft in individual drivers.

I agree, but it should probably not be delayed for too much longer.

[snip]

> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_vga.c
> > b/drivers/gpu/drm/rcar-du/rcar_du_vga.c new file mode 100644
> > index 0000000..2e488dd
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_vga.c

[snip]

> > +static int rcar_du_vga_connector_get_modes(struct drm_connector
> > *connector)
> > +{
> > +	return drm_add_modes_noedid(connector, 1280, 768);
> > +}
> 
> This (and the dummy detect function below) looks a bit funny, since it
> essentially overrides the default behaviour already provided by the crtc
> helpers. Until rcar has at least proper detect support for VGA

I would add that but the DDC signals are not connected on the boards I have 
access to :-/

> I'd just kill this and use the connector force support (and manually adding
> the right resolutions).

Looks like that's a candidate for better documentation... How does force 
support work ?

> So just a return 0; here feels better imo.

-- 
Regards,

Laurent Pinchart

