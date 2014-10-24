From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2014 13:58:34 +0000
Subject: Re: [PATCH v2 6/9] drm: Decouple EDID parsing from I2C adapter
Message-Id: <CAMuHMdXF_m2gK2qYvExhAS-J4TXjv8f-5X0bAq--PswAsgjbnA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414155495-3979-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414155495-3979-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414155495-3979-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Oct 24, 2014 at 2:58 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -279,4 +279,8 @@ int
>  drm_hdmi_vendor_infoframe_from_display_mode(struct hdmi_vendor_infoframe *frame,
>                                             const struct drm_display_mode *mode);
>
> +struct edid *drm_do_get_edid(struct drm_connector *connector,
> +       int (*get_edid_block)(void *, u8 *buf, unsigned int, size_t),

It doesn't hurt to add parameter names for all parameters, as hints
for implementors.

> +       void *data);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
