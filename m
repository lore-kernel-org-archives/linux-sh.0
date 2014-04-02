From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Apr 2014 11:54:31 +0000
Subject: Re: [WIP 1/7] drm: Decouple EDID parsing from I2C adapter
Message-Id: <CAMuHMdUxvC0kU0wMyqo0Mqqd7uaoh-f08=rLNoG7pk2M3iWCOQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396439205-26199-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396439205-26199-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent, Lars-Peter,

On Wed, Apr 2, 2014 at 1:46 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> From: Lars-Peter Clausen <lars@metafoo.de>

> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -1106,9 +1106,10 @@ EXPORT_SYMBOL(drm_edid_is_valid);
>   * Try to fetch EDID information by calling i2c driver function.
>   */
>  static int
> -drm_do_probe_ddc_edid(struct i2c_adapter *adapter, unsigned char *buf,
> +drm_do_probe_ddc_edid(void *data, unsigned char *buf,
>                       int block, int len)

If you touch the signature, I suggest to also change the buffer pointer
to "void *", and its size to "unsigned int".
"block" should also be "unsigned int"?

> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -274,4 +274,8 @@ int
>  drm_hdmi_vendor_infoframe_from_display_mode(struct hdmi_vendor_infoframe *frame,
>                                             const struct drm_display_mode *mode);
>
> +struct edid *drm_do_get_edid(struct drm_connector *connector,
> +       int (*get_edid_block)(void *, unsigned char *buf, int, int),
> +       void *data);

Same here, this is new code, so better get the types right.

> +
>  #endif /* __DRM_EDID_H__ */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
