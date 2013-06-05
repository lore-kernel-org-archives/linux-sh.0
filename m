From: Daniel Vetter <daniel@ffwll.ch>
Date: Wed, 05 Jun 2013 08:55:05 +0000
Subject: Re: [PATCH v3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <20130605085505.GI15743@phenom.ffwll.local>
List-Id: <linux-sh.vger.kernel.org>
References: <1370314420-26524-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1463323.zSQmk3Du5c@avalon>
 <CAKMK7uHA=HBNBZ7jSkB4RZCGRr-9ULLM4Wu3fWrSOqXA=docKw@mail.gmail.com>
 <1706860.sAZ4jDfQzD@avalon>
In-Reply-To: <1706860.sAZ4jDfQzD@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel <dri-devel@lists.freedesktop.org>, linux-sh@vger.kernel.org

On Wed, Jun 05, 2013 at 03:51:53AM +0200, Laurent Pinchart wrote:
> Hi Daniel,
> 
> On Tuesday 04 June 2013 20:36:20 Daniel Vetter wrote:
> > On Tue, Jun 4, 2013 at 8:03 PM, Laurent Pinchart wrote:
> > > On Tuesday 04 June 2013 16:12:36 Daniel Vetter wrote:
> > >> On Tue, Jun 04, 2013 at 04:53:40AM +0200, Laurent Pinchart wrote:

[snip]

> > >> > +static int rcar_du_vga_connector_get_modes(struct drm_connector
> > >> > *connector)
> > >> > +{
> > >> > +   return drm_add_modes_noedid(connector, 1280, 768);
> > >> > +}
> > >> 
> > >> This (and the dummy detect function below) looks a bit funny, since it
> > >> essentially overrides the default behaviour already provided by the crtc
> > >> helpers. Until rcar has at least proper detect support for VGA
> > > 
> > > I would add that but the DDC signals are not connected on the boards I
> > > have access to :-/
> > > 
> > >> I'd just kill this and use the connector force support (and manually
> > >> adding the right resolutions).
> > > 
> > > Looks like that's a candidate for better documentation... How does force
> > > support work ?
> > 
> > Grep for DRM_FORCE_ON, iirc it can be set on the commandline, where you can
> > also force a specific mode. The best I could find wrt docs is the kerneldoc
> > for drm_mode_parse_command_line_for_connector. With a bit more reading it
> > looks like it's intermingled with the fbdev helper code, but should be
> > fairly easy to extract and used by your driver.
> 
> It makes sense to force the connector state from command line, but I'm not 
> sure if the same mechanism is the best solution here. As the driver has no way 
> to know the connector state, the best we can do is guess what modes are 
> supported. I can just return 0 in the get_modes handler, but then the core 
> will not call drm_add_modes_noedid(), and modes will need to be added 
> manually.
> 
> Is your point that for a board on which the VGA connector state can't be 
> detected, the user should always be responsible for adding all the modes 
> supported by the VGA monitor on the command line ?

My point is that we already have both an established code for
connected outputs without EDID to add fallback modes and means to force
connectors to certain states. Your code here seems to reinvent that wheel,
so I wonder what we should/need to improve in the common code to suit your
needs. A few ideas:
- Untangling the connector forcing code from the fbdev helper so that you
  can use it.
- Exposing the connector state forcing through sysfs so that it's
  runtime-adjustable.
- Adding fallback modes for connectors in the unknonw state (imo too much
  risk in breaking something else).

Thinking about this some more I'd vote for the new sysfs file to expose
connector forcing at runtime. With that it'd boil down to 1024x756 vs.
1280x768 for the default fallback mode. And that could be fixed with the
EDID quirk support. Although that looks like it would benefit from a
per-connector sysfs file, too ;-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
