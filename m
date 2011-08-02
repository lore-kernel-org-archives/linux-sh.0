From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Aug 2011 09:42:54 +0000
Subject: [PATCH] serial: sh-sci: fix DMA build by including dma-mapping.h
Message-Id: <20110802094254.2352.12648.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Include dma-mapping.h to fix build of the sh-sci driver on
SH-Mobile ARM (sh73a0) when CONFIG_SERIAL_SH_SCI_DMA=y:

drivers/tty/serial/sh-sci.c: In function 'sci_rx_dma_release':
drivers/tty/serial/sh-sci.c:1182:3: error: implicit declaration of function 'dma_free_coherent'
drivers/tty/serial/sh-sci.c: In function 'work_fn_tx':
drivers/tty/serial/sh-sci.c:1333:2: error: implicit declaration of function 'dma_sync_sg_for_device'
drivers/tty/serial/sh-sci.c: In function 'sci_request_dma':
drivers/tty/serial/sh-sci.c:1498:3: error: implicit declaration of function 'dma_map_sg'
drivers/tty/serial/sh-sci.c:1527:3: error: implicit declaration of function 'dma_alloc_coherent'
drivers/tty/serial/sh-sci.c:1527:10: warning: assignment makes pointer from integer without a cast
make[3]: *** [drivers/tty/serial/sh-sci.o] Error 1
make[2]: *** [drivers/tty/serial] Error 2
make[1]: *** [drivers/tty] Error 2
make: *** [drivers] Error 2

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/tty/serial/sh-sci.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2011-08-02 17:41:43.000000000 +0900
@@ -47,6 +47,7 @@
 #include <linux/ctype.h>
 #include <linux/err.h>
 #include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
 
