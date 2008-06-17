From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 17 Jun 2008 22:30:40 +0000
Subject: [2.6 patch] sh dreamcast: export board_pci_channels
Message-Id: <20080617223040.GI25911@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following build error:

<--  snip  -->

...
  MODPOST 1837 modules
ERROR: "board_pci_channels" [drivers/pcmcia/yenta_socket.ko] undefined!
...
make[2]: *** [__modpost] Error 1

<--  snip  -->

I freely admit that it's a pathological configuration, but as long as 
it is allowed it should build.

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/sh/drivers/pci/ops-dreamcast.c |    2 ++
 1 file changed, 2 insertions(+)

632d9b2b1d3b5f3c0fed0353b098f92e28c4217d diff --git a/arch/sh/drivers/pci/ops-dreamcast.c b/arch/sh/drivers/pci/ops-dreamcast.c
index e1284fc..f54c291 100644
--- a/arch/sh/drivers/pci/ops-dreamcast.c
+++ b/arch/sh/drivers/pci/ops-dreamcast.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -48,6 +49,7 @@ struct pci_channel board_pci_channels[] = {
 	  &gapspci_mem_resource, 0, 1 },
 	{ 0, }
 };
+EXPORT_SYMBOL(board_pci_channels);
 
 /*
  * The !gapspci_config_access case really shouldn't happen, ever, unless
