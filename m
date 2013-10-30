From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Date: Wed, 30 Oct 2013 12:26:23 +0000
Subject: Re: [PATCH 07/19] v4l: sh_vou: Enable the driver on all ARM platforms
Message-Id: <20131030102623.1d498c16@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383004027-25036-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

Em Tue, 29 Oct 2013 00:46:55 +0100
Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com> escreveu:

> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> 
> Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
> Cc: linux-media@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I'm understanding that the plan is to commit it via an ARM tree, right?

If so:
	Acked-by: Mauro Carvalho Chehab <m.chehab@samsung.com>

PS.: With regards to the discussions about this patch series,
I'm ok on having this enabled for all archs or just for the
archs that are known have this IP block, of course provided that
not includes to march are there.

The rationale is that, in the specific case of V4L, the platform 
drivers are already on a separate Kconfig menu, with makes no sense
to be enabled on any non SoC configuration.

> ---
>  drivers/media/platform/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index c7caf94..a726f86 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -36,7 +36,7 @@ source "drivers/media/platform/blackfin/Kconfig"
>  config VIDEO_SH_VOU
>  	tristate "SuperH VOU video output driver"
>  	depends on MEDIA_CAMERA_SUPPORT
> -	depends on VIDEO_DEV && ARCH_SHMOBILE && I2C
> +	depends on VIDEO_DEV && ARM && I2C
>  	select VIDEOBUF_DMA_CONTIG
>  	help
>  	  Support for the Video Output Unit (VOU) on SuperH SoCs.


-- 

Cheers,
Mauro
