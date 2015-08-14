From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 14 Aug 2015 20:44:47 +0000
Subject: Re: [PATCH v2] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <8651511.IKVhtFr2ll@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wednesday 29 July 2015 16:32:43 Magnus Damm wrote:
> Hi Laurent, Morimoto-san, everyone,
> 
> I have now together with Morimoto-san tried to get a bit closer to
> tracking down what the issue is for LVDS on Lager. This is what we
> have observed so far:
> 
> - On Koelsch both LVDS panels work fine (aa104xd12 and aa121td01).
> - On Koelsch HDMI works well too.

Good news so far :-)

> - On Lager the VGA output seems to work.
> - On Lager the LVDS panel output does not work.
> - On Lager the HDMI does not work.

How do they "not work" ?

I've tested both here using modetest without any issue, neither with renesas-
devel-20150729-v4.2-rc4 nor with renesas-drivers-2015-07-14-v4.2-rc2. To test 
HDMI, I ran (your connector numbers may vary)

modetest -M rcar-du -s 44:1280x800@AR24

and to test LVDS

modetest -M rcar-du -s 46:1280x800@AR24

after applying Morimoto-san's AA121TD01 panel patch.

The HDMI tests were performed twice, once with the display connected at boot 
and once after connecting the display at runtime. Both worked fine, the screen 
showed the fbdev console and the test pattern when running modetest.

As my LVDS panel is an AA104XD12 the image showed some artifacts when fed with 
1280x800 (most notably cropping and a bit of flickering), but it worked 
nonetheless.

> - On Lager we get the crash described by Morimoto-san using the 1280x800
> panel.

I couldn't reproduce that crash either.

> - On Lager we get no crash if we use the 1024x768 panel.
> 
> We seem to have some issues with Lager. =)
> 
> The Lager crash disappears if we force use of DU2 on LVDS1:
> 
> --- 0001/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ work/drivers/gpu/drm/rcar-du/rcar_du_drv.c    2015-07-29
> 16:24:21.212366518 +0900
> @@ -66,7 +66,7 @@ static const struct rcar_du_device_info
>           * (currently unsupported) TCON output.
>           */
>          [RCAR_DU_OUTPUT_DPAD0] = {
> -            .possible_crtcs = BIT(2) | BIT(1) | BIT(0),
> +            .possible_crtcs = BIT(1) | BIT(0),
>              .encoder_type = DRM_MODE_ENCODER_NONE,
>              .port = 0,
>          },
> @@ -76,7 +76,7 @@ static const struct rcar_du_device_info
>              .port = 1,
>          },
>          [RCAR_DU_OUTPUT_LVDS1] = {
> -            .possible_crtcs = BIT(2) | BIT(1),
> +            .possible_crtcs = BIT(2),
>              .encoder_type = DRM_MODE_ENCODER_LVDS,
>              .port = 2,
>          },
> 
> Regardless of if the crash disappears or not we still get no output on
> the LVDS panel on Lager.
>
> As for kernel, Morimoto-san used renesas-drivers-2015-07-14-v4.2-rc2
> with a real LVDS panel and I used renesas-devel-20150729-v4.2-rc4
> without panel connected (but added 1024x768 panel in DTS).
> 
> Any ideas?

That might be a bit of a stupid question, but have you verified that the 
connectors pinout (both data and backlight) is compatible ?

-- 
Regards,

Laurent Pinchart

