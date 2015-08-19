From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Date: Wed, 19 Aug 2015 16:58:37 +0000
Subject: Re: [PATCH 0/4] [media] Media entity cleanups and build fixes
Message-Id: <20150819135837.7775703c@recife.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <1439998526-12832-1-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1439998526-12832-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-sh@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>, Hyun Kwon <hyun.kwon@xilinx.com>, linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, "Prabhakar\"" <prabhakar.csengg@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org

Hi Javier,

Em Wed, 19 Aug 2015 17:35:18 +0200
Javier Martinez Canillas <javier@osg.samsung.com> escreveu:

> Hello,
> 
> This series contains a couple of build fixes and cleanups for the
> Media Controller framework. The goal of the series is to get rid of
> the struct media_entity .parent member since now that a media_gobj is
> embedded into entities, the media_gobj .mdev member can be used to
> store a pointer to the parent struct media_device.
> 
> So the .parent field becomes redundant and can be removed after all
> the users are converted to use entity .graph_obj.mdev instead.
> 
> Patches 1/4 and 2/4 are build fixes I found while build testing if no
> regressions were introduced by the conversion. 

Crap. Those omap drivers depend on some sub-arch specific DMA functions,
and can't use COMPILE_TEST. I hope some day someone would fix it,
in order to avoid troubles like that.

> Patch 3/4 converts
> all the drivers and the MC core to use .mdev instead of .parent and
> finally patch 4/4 removes the .parent field since now is unused.

Thanks for that!
All patches look good on my eyes.
> 
> The series depend on Mauro's "[PATCH v6 0/8] MC preparation patches
> series" [0].

I'll add those patches on my experimental branch together with the
other patches that belong to the MC next gen rework.

> 
> The transformation were automated using a coccinelle semantic patch
> and the drivers were build tested using allyesconfig and x-building
> the ARM Exynos and OMAP defconfigs + the needed media config options.
> 
> Best regards,
> Javier
> 
> [0]: http://www.mail-archive.com/linux-media@vger.kernel.org/msg91330.html
> 
> 
> Javier Martinez Canillas (4):
>   [media] staging: omap4iss: get entity ID using media_entity_id()
>   [media] omap3isp: get entity ID using media_entity_id()
>   [media] media: use entity.graph_obj.mdev instead of .parent
>   [media] media: remove media entity .parent field
> 
>  drivers/media/media-device.c                       |  8 ++---
>  drivers/media/media-entity.c                       | 34 ++++++++++++----------
>  drivers/media/platform/exynos4-is/fimc-isp-video.c |  6 ++--
>  drivers/media/platform/exynos4-is/fimc-lite.c      |  8 ++---
>  drivers/media/platform/exynos4-is/media-dev.c      |  2 +-
>  drivers/media/platform/exynos4-is/media-dev.h      |  8 ++---
>  drivers/media/platform/omap3isp/isp.c              | 11 ++++---
>  drivers/media/platform/omap3isp/ispccdc.c          |  2 +-
>  drivers/media/platform/omap3isp/ispvideo.c         | 10 ++++---
>  drivers/media/platform/vsp1/vsp1_video.c           |  2 +-
>  drivers/media/platform/xilinx/xilinx-dma.c         |  2 +-
>  drivers/staging/media/davinci_vpfe/vpfe_video.c    |  6 ++--
>  drivers/staging/media/omap4iss/iss.c               |  6 ++--
>  drivers/staging/media/omap4iss/iss_video.c         |  4 +--
>  include/media/media-entity.h                       |  1 -
>  15 files changed, 58 insertions(+), 52 deletions(-)
> 

Thanks and regards,
Mauro
