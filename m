From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 29 Jun 2014 09:10:05 +0000
Subject: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/dma/sh/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 1ce88b28cfc6..275297a89bd5 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -1,3 +1,6 @@
+ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+
 obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
 obj-$(CONFIG_SH_DMAE) += shdma.o
 shdma-y := shdmac.o
-- 
2.0.0

