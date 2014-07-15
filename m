From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 15 Jul 2014 16:30:08 +0000
Subject: Re: [PATCH v3] dmaengine: inherit debug settings from the subsystem for subdirectories
Message-Id: <20140715161808.GI4387@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405370846-13986-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1405370846-13986-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 14, 2014 at 10:47:26PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> To be able to see debug messages during boot, enable the debug settings
> from Kconfig also for drivers in subdirectories.
> 
Applied, thanks

-- 
~Vinod

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/dma/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index c779e1eb2db2..aca5eb577d44 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -1,5 +1,5 @@
> -ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
> -ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
> +subdir-ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
> +subdir-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
>  
>  obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
>  obj-$(CONFIG_DMA_VIRTUAL_CHANNELS) += virt-dma.o
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
