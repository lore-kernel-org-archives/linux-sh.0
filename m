From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 03 Apr 2014 00:12:39 +0000
Subject: Re: [WIP 1/7] drm: Decouple EDID parsing from I2C adapter
Message-Id: <2998648.mNRJR98WlL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1396439205-26199-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396439205-26199-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the review.

On Wednesday 02 April 2014 13:54:31 Geert Uytterhoeven wrote:
> On Wed, Apr 2, 2014 at 1:46 PM, Laurent Pinchart wrote:
> > From: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -1106,9 +1106,10 @@ EXPORT_SYMBOL(drm_edid_is_valid);
> >   * Try to fetch EDID information by calling i2c driver function.
> >   */
> >  static int
> > -drm_do_probe_ddc_edid(struct i2c_adapter *adapter, unsigned char *buf,
> > +drm_do_probe_ddc_edid(void *data, unsigned char *buf,
> >                       int block, int len)
> 
> If you touch the signature, I suggest to also change the buffer pointer
> to "void *", and its size to "unsigned int".

I'd even go for size_t for the size. What about u8 * for the buffer, given 
that it's really a buffer of bytes ?

> "block" should also be "unsigned int"?

Indeed.

> > --- a/include/drm/drm_edid.h
> > +++ b/include/drm/drm_edid.h
> > @@ -274,4 +274,8 @@ int
> >  drm_hdmi_vendor_infoframe_from_display_mode(struct hdmi_vendor_infoframe
> >  *frame,
> >                                             const struct drm_display_mode
> >                                             *mode);
> > +struct edid *drm_do_get_edid(struct drm_connector *connector,
> > +       int (*get_edid_block)(void *, unsigned char *buf, int, int),
> > +       void *data);
> 
> Same here, this is new code, so better get the types right.
> 
> > +
> >  #endif /* __DRM_EDID_H__ */

-- 
Regards,

Laurent Pinchart

