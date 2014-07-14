From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 14 Jul 2014 20:47:26 +0000
Subject: [PATCH v3] dmaengine: inherit debug settings from the subsystem for subdirectories
Message-Id: <1405370846-13986-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

To be able to see debug messages during boot, enable the debug settings
from Kconfig also for drivers in subdirectories.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/dma/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index c779e1eb2db2..aca5eb577d44 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -1,5 +1,5 @@
-ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
+subdir-ccflags-$(CONFIG_DMADEVICES_DEBUG)  := -DDEBUG
+subdir-ccflags-$(CONFIG_DMADEVICES_VDEBUG) += -DVERBOSE_DEBUG
 
 obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
 obj-$(CONFIG_DMA_VIRTUAL_CHANNELS) += virt-dma.o
-- 
2.0.0

