From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Jul 2014 01:26:22 +0000
Subject: Re: [PATCH] dmaengine: sh: Rename CONFIG_SHDMA_R8A73A4 to CONFIG_SH_DMAE_R8A73A4
Message-Id: <20140729012622.GI19235@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1406575006-21319-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1406575006-21319-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 28, 2014 at 09:16:46PM +0200, Laurent Pinchart wrote:
> Commit b1aad1586867 ("dmaengine: sh: Rework Kconfig and Makefile")
> renamed the Kconfig symbol SHDMA_R8A73A4 to SH_DMAE_R8A73A4 but forgot
> to rename two instances of CONFIG_SHDMA_R8A73A4. Rename them.
> 
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/dma/sh/Makefile | 2 +-
>  drivers/dma/sh/shdma.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
> index cfc8268..2852f9d 100644
> --- a/drivers/dma/sh/Makefile
> +++ b/drivers/dma/sh/Makefile
> @@ -9,7 +9,7 @@ obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
>  #
>  
>  shdma-y := shdmac.o
> -shdma-$(CONFIG_SHDMA_R8A73A4) += shdma-r8a73a4.o
> +shdma-$(CONFIG_SH_DMAE_R8A73A4) += shdma-r8a73a4.o
>  shdma-objs := $(shdma-y)
>  obj-$(CONFIG_SH_DMAE) += shdma.o
>  
> diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
> index 758a57b..2c0a969 100644
> --- a/drivers/dma/sh/shdma.h
> +++ b/drivers/dma/sh/shdma.h
> @@ -62,7 +62,7 @@ struct sh_dmae_desc {
>  #define to_sh_dev(chan) container_of(chan->shdma_chan.dma_chan.device,\
>  				     struct sh_dmae_device, shdma_dev.dma_dev)
>  
> -#ifdef CONFIG_SHDMA_R8A73A4
> +#ifdef CONFIG_SH_DMAE_R8A73A4
>  extern const struct sh_dmae_pdata r8a73a4_dma_pdata;
>  #define r8a73a4_shdma_devid (&r8a73a4_dma_pdata)
>  #else

Thanks Laurent,

I have decided to squash this into "dmaengine: sh: Rework Kconfig and
Makefile". I will push the following shortly:


From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

[PATCH] dmaengine: sh: Rework Kconfig and Makefile

Separate helpers and drivers in the Kconfig and Makefile to improve
readability and move the CONFIG_OF dependency from the Makefile to
Kconfig.

[pebolle@tiscali.nl: reported need to rename SHDMA_R8A73A4 instances]
Reported-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas@verge.net.au: squashed rename of SHDMA_R8A73A4 instances]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/dma/sh/Kconfig  | 24 +++++++++++++++++++-----
 drivers/dma/sh/Makefile | 16 ++++++++++++----
 drivers/dma/sh/shdma.h  |  2 +-
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 0f71981..0349125 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -2,21 +2,39 @@
 # DMA engine configuration for sh
 #
 
+#
+# DMA Engine Helpers
+#
+
 config SH_DMAE_BASE
 	bool "Renesas SuperH DMA Engine support"
-	depends on (SUPERH && SH_DMA) || ARCH_SHMOBILE || COMPILE_TEST
+	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
+	depends on !SUPERH || SH_DMA
 	depends on !SH_DMA_API
 	default y
 	select DMA_ENGINE
 	help
 	  Enable support for the Renesas SuperH DMA controllers.
 
+#
+# DMA Controllers
+#
+
 config SH_DMAE
 	tristate "Renesas SuperH DMAC support"
 	depends on SH_DMAE_BASE
 	help
 	  Enable support for the Renesas SuperH DMA controllers.
 
+if SH_DMAE
+
+config SH_DMAE_R8A73A4
+	def_bool y
+	depends on ARCH_R8A73A4
+	depends on OF
+
+endif
+
 config SUDMAC
 	tristate "Renesas SUDMAC support"
 	depends on SH_DMAE_BASE
@@ -34,7 +52,3 @@ config RCAR_AUDMAC_PP
 	depends on SH_DMAE_BASE
 	help
 	  Enable support for the Renesas R-Car Audio DMAC Peripheral Peripheral controllers.
-
-config SHDMA_R8A73A4
-	def_bool y
-	depends on ARCH_R8A73A4 && SH_DMAE != n
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 1ce88b2..0a5cfdb 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -1,10 +1,18 @@
+#
+# DMA Engine Helpers
+#
+
 obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
-obj-$(CONFIG_SH_DMAE) += shdma.o
+
+#
+# DMA Controllers
+#
+
 shdma-y := shdmac.o
-ifeq ($(CONFIG_OF),y)
-shdma-$(CONFIG_SHDMA_R8A73A4) += shdma-r8a73a4.o
-endif
+shdma-$(CONFIG_SH_DMAE_R8A73A4) += shdma-r8a73a4.o
 shdma-objs := $(shdma-y)
+obj-$(CONFIG_SH_DMAE) += shdma.o
+
 obj-$(CONFIG_SUDMAC) += sudmac.o
 obj-$(CONFIG_RCAR_HPB_DMAE) += rcar-hpbdma.o
 obj-$(CONFIG_RCAR_AUDMAC_PP) += rcar-audmapp.o
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 758a57b..2c0a969 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -62,7 +62,7 @@ struct sh_dmae_desc {
 #define to_sh_dev(chan) container_of(chan->shdma_chan.dma_chan.device,\
 				     struct sh_dmae_device, shdma_dev.dma_dev)
 
-#ifdef CONFIG_SHDMA_R8A73A4
+#ifdef CONFIG_SH_DMAE_R8A73A4
 extern const struct sh_dmae_pdata r8a73a4_dma_pdata;
 #define r8a73a4_shdma_devid (&r8a73a4_dma_pdata)
 #else
-- 
2.0.1

