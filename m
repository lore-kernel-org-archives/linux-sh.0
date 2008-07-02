From: Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
Date: Wed, 02 Jul 2008 07:27:12 +0000
Subject: Re: [PATCH 02/07] soc_camera: Let the host select videobuf_queue
Message-Id: <486B2DD0.7060903@teltonika.lt>
List-Id: <linux-sh.vger.kernel.org>
References: <20080701124638.30446.81449.sendpatchset@rx1.opensource.se>
	<20080701124657.30446.28078.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080701124657.30446.28078.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: video4linux-list@redhat.com
Cc: linux-sh@vger.kernel.org

Magnus Damm wrote:
> This patch makes it possible for hosts (soc_camera drivers for the soc)
> to select a different videobuf queue than VIDEOBUF_DMA_SG. This is needed
> by the SuperH Mobile CEU hardware which requires physically contiguous
> buffers. While at it, rename the spinlock callbacks to file callbacks.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  drivers/media/video/Kconfig      |    4 ++--
>  drivers/media/video/pxa_camera.c |   15 ++++++++++++---
>  drivers/media/video/soc_camera.c |   27 +++++++--------------------
>  include/media/soc_camera.h       |    6 +++---
>  4 files changed, 24 insertions(+), 28 deletions(-)
> 
> --- 0001/drivers/media/video/Kconfig
> +++ work/drivers/media/video/Kconfig	2008-07-01 13:05:48.000000000 +0900
> @@ -901,8 +901,7 @@ endif # V4L_USB_DRIVERS
>  
>  config SOC_CAMERA
>  	tristate "SoC camera support"
> -	depends on VIDEO_V4L2 && HAS_DMA
> -	select VIDEOBUF_DMA_SG
> +	depends on VIDEO_V4L2

Bug here. You won't be able to compile soc_camera without host driver
or host driver as module. SOC_CAMERA has to select VIDEOBUF_GEN!

>  	help
>  	  SoC Camera is a common API to several cameras, not connecting
>  	  over a bus like PCI or USB. For example some i2c camera connected

