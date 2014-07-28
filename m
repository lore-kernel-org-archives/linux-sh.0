From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Jul 2014 19:16:46 +0000
Subject: [PATCH] dmaengine: sh: Rename CONFIG_SHDMA_R8A73A4 to CONFIG_SH_DMAE_R8A73A4
Message-Id: <1406575006-21319-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit b1aad1586867 ("dmaengine: sh: Rework Kconfig and Makefile")
renamed the Kconfig symbol SHDMA_R8A73A4 to SH_DMAE_R8A73A4 but forgot
to rename two instances of CONFIG_SHDMA_R8A73A4. Rename them.

Reported-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/sh/Makefile | 2 +-
 drivers/dma/sh/shdma.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index cfc8268..2852f9d 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
 #
 
 shdma-y := shdmac.o
-shdma-$(CONFIG_SHDMA_R8A73A4) += shdma-r8a73a4.o
+shdma-$(CONFIG_SH_DMAE_R8A73A4) += shdma-r8a73a4.o
 shdma-objs := $(shdma-y)
 obj-$(CONFIG_SH_DMAE) += shdma.o
 
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
Regards,

Laurent Pinchart

