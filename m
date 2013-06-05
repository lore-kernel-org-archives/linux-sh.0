From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 05 Jun 2013 01:51:53 +0000
Subject: Re: [PATCH v3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <1706860.sAZ4jDfQzD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1370314420-26524-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1463323.zSQmk3Du5c@avalon> <CAKMK7uHA=HBNBZ7jSkB4RZCGRr-9ULLM4Wu3fWrSOqXA=docKw@mail.gmail.com>
In-Reply-To: <CAKMK7uHA=HBNBZ7jSkB4RZCGRr-9ULLM4Wu3fWrSOqXA=docKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-sh@vger.kernel.org

Hi Daniel,

On Tuesday 04 June 2013 20:36:20 Daniel Vetter wrote:
> On Tue, Jun 4, 2013 at 8:03 PM, Laurent Pinchart wrote:
> > On Tuesday 04 June 2013 16:12:36 Daniel Vetter wrote:
> >> On Tue, Jun 04, 2013 at 04:53:40AM +0200, Laurent Pinchart wrote:
>
> [snip]
> 
> >> Should we add that to crtc helpers, instead of the current "just try to
> >> smash the old config on top of the ill-defined hw state after a failed
> >> modeset"?
> > 
> > It would probably make sense to add a rollback operation to undo the
> > prepare operation, or maybe just a rollback/commit flag to the commit
> > operation. We would still need to smash the old config back though, as
> > the rollback operation shouldn't be expected to handle encoders and
> > connectors.
> > 
> > While we're at it, shouldn't we make drivers report supported formats for
> > the main frame buffer, like we do for planes ? That would allow catching
> > format errors before calling the prepare operation.
> 
> Yeah, I've noticed that one, too. I guess we could tackle that as part
> of an eventual "make the implicit primary plane a bit more explict"
> project. For now I'm not too offended by the duplication of checks.

It would be nice to treat the primary plane as all the other planes. Several 
embedded display engines don't make the primary plane special and just paint 
the background with a plain color when the enabled planes don't cover the 
entire display.

> >> This should use the drm_send_vblank_event helper.
> > 
> > What bothers me about drm_send_vblank_event() is that it calls
> > drm_vblank_count_and_time() with the events lock unnecessarily held. I can
> > live with that for now, I'll fix the driver to use the helper.
> 
> Most other drivers protect a bit of other state with that lock, so
> makes sense to hold it outside already. So not sure whether we should
> optimize this much ...

Probably not :-)

> >> > +   drm_vblank_put(dev, rcrtc->index);
> >> > +}
> > 
> > [snip]
> > 
> >> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> > b/drivers/gpu/drm/rcar-du/rcar_du_drv.c new file mode 100644
> >> > index 0000000..003b34e
> >> > --- /dev/null
> >> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> > 
> > [snip]
> > 
> >> > +static void rcar_du_disable_vblank(struct drm_device *dev, int crtc)
> >> > +{
> >> > +   struct rcar_du_device *rcdu = dev->dev_private;
> >> > +
> >> > +   rcar_du_crtc_enable_vblank(&rcdu->crtcs[crtc], false);
> >> > +}
> >> 
> >> Blergh, I hate our legacy vblank code which forces kms driver to jump
> >> through int pipe -> struct drm_crtc * hoops.
> > 
> > How would you like to fix it ? :-)
> 
> Haven't looked at the details, but the first step I have in mind is to
> switch all drm core -> driver and driver -> vblank helper interfaces from
> int pipe to struct drm_crtc * pointers for kms drivers. That would allow us
> to implement at least sane locking for the vblank wait ioctl (by grabbing
> the crtc mutex).
> 
> My plan was to split things by copy&pasting new kms functions and then
> garbage-collecting all unnused features for the ums code (iirc no ums driver
> ever supported more than 2 crtcs, vblank events or high-precision
> timestamps).
> 
> Once that's in place we can look into more stuff. One of the things I want
> to play with is support for hw timestamp and vblank counters (also for
> pageflips). Then we don't have to enable the vblank interrupt so often and
> more important should be able to turn it of right away without loosing
> precision due to the potential vblank irq vs. vblank irq off race.
> 
> >> where i counts encoders to say that you can clone itself (userspace might
> >> get confused, haven't checked how throughout the modeset ddx is). But it
> >> sounds like rcar can clone encoders pretty freely (as long as they're
> >> using crtc 0), so maybe you want to use something like drm/i915 does?
> > 
> > The device has two outputs, 0 and 1. Output 0 can be driven by CRTC 0
> > only, and output 1 can be driven by CRTC 0 or CRTC 1.
> 
> Ah, that explains it, I've missed the context that we only have 2
> crtc/encoder pairs ;-)

It wasn't particularly explicit :-)

> >> We smash all cloneable encoders into one groub with a
> >> intel_encoder->cloneable flag and then allow cloning any cloneable
> >> encoder to any other cloneable encoder with intel_encoder_clones in
> >> intel_display.c
> >> 
> >> possible_clones is a bit a ill-defined part of the kms api, but I think
> >> we still should strive for consistency. Maybe the modesetting ddx should
> >> also grow a warning if the possible_clones mask doesn't make too much
> >> sense.
> > 
> > I haven't been able to find an authoritative source of documentation
> > regarding whether the possible_clones field should include the encoder
> > itself. That should definitely be documented, I can fix the driver
> > accordingly.
>
> Yeah, sounds like something worth clarifying. I'd vote for the self-clone
> bit to be set (I'm biased though, that's what i915 does). I guess we could
> even enforce consistency by putting this into the drm encoders.

I don't have a strong opinion on the color of this particular bikeshed, but it 
would be nice to hear what other developers think.

> Since the modesetting driver seems to not care too much I guess we can
> fix that later on, imo not something to block merging rcar on.

OK, thanks. I'll fix that (and the documentation) later after we decide on 
whether an encoder can self-clone.

> [snip]
> 
> >> > +static int rcar_du_vga_connector_get_modes(struct drm_connector
> >> > *connector)
> >> > +{
> >> > +   return drm_add_modes_noedid(connector, 1280, 768);
> >> > +}
> >> 
> >> This (and the dummy detect function below) looks a bit funny, since it
> >> essentially overrides the default behaviour already provided by the crtc
> >> helpers. Until rcar has at least proper detect support for VGA
> > 
> > I would add that but the DDC signals are not connected on the boards I
> > have access to :-/
> > 
> >> I'd just kill this and use the connector force support (and manually
> >> adding the right resolutions).
> > 
> > Looks like that's a candidate for better documentation... How does force
> > support work ?
> 
> Grep for DRM_FORCE_ON, iirc it can be set on the commandline, where you can
> also force a specific mode. The best I could find wrt docs is the kerneldoc
> for drm_mode_parse_command_line_for_connector. With a bit more reading it
> looks like it's intermingled with the fbdev helper code, but should be
> fairly easy to extract and used by your driver.

It makes sense to force the connector state from command line, but I'm not 
sure if the same mechanism is the best solution here. As the driver has no way 
to know the connector state, the best we can do is guess what modes are 
supported. I can just return 0 in the get_modes handler, but then the core 
will not call drm_add_modes_noedid(), and modes will need to be added 
manually.

Is your point that for a board on which the VGA connector state can't be 
detected, the user should always be responsible for adding all the modes 
supported by the VGA monitor on the command line ?

-- 
Regards,

Laurent Pinchart

