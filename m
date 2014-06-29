From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 29 Jun 2014 19:56:43 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <29880309.jbmcOH83Zx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Sunday 29 June 2014 11:10:05 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/dma/sh/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
> index 1ce88b28cfc6..275297a89bd5 100644
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -1,3 +1,6 @@
> +ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG

Isn't this discouraged in favour of using dynamic printk ? I've recently 
submitted a similar patch for the OMAP4 ISS driver and it got nacked.

> +ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
> +
>  obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
>  obj-$(CONFIG_SH_DMAE) += shdma.o
>  shdma-y := shdmac.o

-- 
Regards,

Laurent Pinchart

