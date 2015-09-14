From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2015 07:52:10 +0000
Subject: Re: [PATCH 00/22] R-Car DU: Add Gen3 support
Message-Id: <CAMuHMdXwKE1J5029zR77u9z1X6gLiViMLT=VgY_uhW7DkCnwHA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442184669-30990-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Mon, Sep 14, 2015 at 12:50 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> This patch series adds support for the Display Unit found in the R-Car Gen3
> SoC series.
>
> The third generation differs significantly from the previous ones in that the
> DU has lost its ability to source data from memory. It must instead use an
> external hardware composer named VSP to read planes from memory and blend
> them.
>
> The VSP has a V4L2 driver in mainline that can be used in conjunction with the
> DU through the live sources API (submitted previously as an RFC). However, as
> VSP usage is mandatory in Gen3 and as no native DU planes are available, we
> have decided that forcing userspace to use both KMS and V4L2 to display any
> content wouldn't be very friendly. Instead the VSP driver has been extended to
> make the device directly controllable by the DU driver ([1]) and this patch
> series builds on top of it.
>
> [1] http://www.spinics.net/lists/linux-media/msg93575.html

Against which tree is this series?

From patch 1, I derived it's against drm-misc
(git://anongit.freedesktop.org/drm-intel#topic/drm-misc), but later patches
have other requirements.
E.g. patch 13 assumes DRM_RCAR_DU has a dependency on OF, but that's nowhere
to be found in -next.
It is in git://linuxtv.org/pinchartl/media#vsp1-kms-gen3-20150909.2, but that
conflicts badly with your R-Car Gen3 VSP series.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
