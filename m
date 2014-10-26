From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 26 Oct 2014 14:43:52 +0000
Subject: Re: [PATCH v2 6/9] drm: Decouple EDID parsing from I2C adapter
Message-Id: <1841308.v8gkVZqzX1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414155495-3979-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414155495-3979-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CAMuHMdXF_m2gK2qYvExhAS-J4TXjv8f-5X0bAq--PswAsgjbnA@mail.gmail.com>
In-Reply-To: <CAMuHMdXF_m2gK2qYvExhAS-J4TXjv8f-5X0bAq--PswAsgjbnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

Thank you for the review.

On Friday 24 October 2014 15:58:34 Geert Uytterhoeven wrote:
> On Fri, Oct 24, 2014 at 2:58 PM, Laurent Pinchart
> 
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -279,4 +279,8 @@ int
> >  drm_hdmi_vendor_infoframe_from_display_mode(struct hdmi_vendor_infoframe
> >  *frame,
> >                                             const struct drm_display_mode
> >                                             *mode);
> > +struct edid *drm_do_get_edid(struct drm_connector *connector,
> > +       int (*get_edid_block)(void *, u8 *buf, unsigned int, size_t),
> 
> It doesn't hurt to add parameter names for all parameters, as hints
> for implementors.

Good point, I'll fix that.

> > +       void *data);

-- 
Regards,

Laurent Pinchart

