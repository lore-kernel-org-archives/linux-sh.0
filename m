From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 14 Jun 2013 14:03:19 +0000
Subject: Re: [PATCH v3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <20130614140318.GK23483@phenom.ffwll.local>
List-Id: <linux-sh.vger.kernel.org>
References: <1370314420-26524-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <4571041.QYQjiyisGP@avalon>
 <20130607085055.GP7827@phenom.ffwll.local>
 <1393060.SF8x67qbTg@avalon>
In-Reply-To: <1393060.SF8x67qbTg@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-sh@vger.kernel.org, Adam Jackson <ajax@redhat.com>

On Fri, Jun 14, 2013 at 02:54:04AM +0200, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Friday 07 June 2013 10:50:55 Daniel Vetter wrote:
> > On Fri, Jun 07, 2013 at 09:44:45AM +0200, Laurent Pinchart wrote:
> > > On Wednesday 05 June 2013 10:55:05 Daniel Vetter wrote:
> > > > On Wed, Jun 05, 2013 at 03:51:53AM +0200, Laurent Pinchart wrote:
> > > > > On Tuesday 04 June 2013 20:36:20 Daniel Vetter wrote:
> > > > > > On Tue, Jun 4, 2013 at 8:03 PM, Laurent Pinchart wrote:
> > > > > > > On Tuesday 04 June 2013 16:12:36 Daniel Vetter wrote:
> > > > > > >> On Tue, Jun 04, 2013 at 04:53:40AM +0200, Laurent Pinchart wrote:
> > > > [snip]
> > > > 
> > > > > > >> > +static int rcar_du_vga_connector_get_modes(struct
> > > > > > >> > drm_connector
> > > > > > >> > *connector)
> > > > > > >> > +{
> > > > > > >> > +   return drm_add_modes_noedid(connector, 1280, 768);
> > > > > > >> > +}
> > > > > > >> 
> > > > > > >> This (and the dummy detect function below) looks a bit funny,
> > > > > > >> since it essentially overrides the default behaviour already
> > > > > > >> provided by the crtc helpers. Until rcar has at least proper
> > > > > > >> detect support for VGA
> > > > > > > 
> > > > > > > I would add that but the DDC signals are not connected on the
> > > > > > > boards I have access to :-/
> > > > > > > 
> > > > > > >> I'd just kill this and use the connector force support (and
> > > > > > >> manually adding the right resolutions).
> > > > > > > 
> > > > > > > Looks like that's a candidate for better documentation... How does
> > > > > > > force support work ?
> > > > > > 
> > > > > > Grep for DRM_FORCE_ON, iirc it can be set on the commandline, where
> > > > > > you can also force a specific mode. The best I could find wrt docs
> > > > > > is the kerneldoc for drm_mode_parse_command_line_for_connector. With
> > > > > > a bit more reading it looks like it's intermingled with the fbdev
> > > > > > helper code, but should be fairly easy to extract and used by your
> > > > > > driver.
> > > > > 
> > > > > It makes sense to force the connector state from command line, but I'm
> > > > > not sure if the same mechanism is the best solution here. As the
> > > > > driver has no way to know the connector state, the best we can do is
> > > > > guess what modes are supported. I can just return 0 in the get_modes
> > > > > handler, but then the core will not call drm_add_modes_noedid(), and
> > > > > modes will need to be added manually.
> > > > > 
> > > > > Is your point that for a board on which the VGA connector state can't
> > > > > be detected, the user should always be responsible for adding all the
> > > > > modes supported by the VGA monitor on the command line ?
> > > > 
> > > > My point is that we already have both an established code for connected
> > > > outputs without EDID to add fallback modes and means to force connectors
> > > > to certain states. Your code here seems to reinvent that wheel, so I
> > > > wonder what we should/need to improve in the common code to suit your
> > > > needs.
> > > 
> > > The currently available code might suit my needs, it might just be that I
> > > fail to see how to use it properly.
> > > 
> > > Regarding the "code for connected outputs without EDID to add fallback
> > > modes" you're referring to, is that
> > > 
> > >         if (count = 0 && connector->status = connector_status_connected)
> > >                 count = drm_add_modes_noedid(connector, 1024, 768);
> > > 
> > > in drm_helper_probe_single_connector_modes() ? That function will only be
> > > called if the connector status is connector_status_connected. There are
> > > two ways to enforce that:
> > > 
> > > - returning connector_status_connected from the connector detect()
> > > operation, which seems to defeat the purpose of having
> > > connector_status_unknown completely.
> > 
> > We might want to add such a default mode also for unknown, I'm not sure.
> > Userspace policy is to first try to light up any connected outputs, and if
> > there's none try to light up any unknown outputs. Not sure whether userspace
> > (i.e. X) will automatically add a default mode. fbcon might also handle this
> > less gracefully.
> > 
> > Personally I'm ok with extending this to unknown, it shouldn't really hurt
> > (since we already try really hard not to leak unknown anywhere visible).
> 
> Do you mean something like
> 
> diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
> index f554516..9aae384 100644
> --- a/drivers/gpu/drm/drm_crtc_helper.c
> +++ b/drivers/gpu/drm/drm_crtc_helper.c
> @@ -160,7 +160,8 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
>  #endif
>  		count = (*connector_funcs->get_modes)(connector);
>  
> -	if (count = 0 && connector->status = connector_status_connected)
> +	if (count = 0 && (connector->status = connector_status_connected ||
> +			   connector->status = connector_status_unknown))
>  		count = drm_add_modes_noedid(connector, 1024, 768);
>  	if (count = 0)
>  		goto prune;
> 
> If so I can submit a proper patch.

Yeah, but Ajax is the guy with the opinion that matters here. Cc'ed.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
