From: Kulikov Vasiliy <segooon@gmail.com>
Date: Wed, 28 Jul 2010 16:39:26 +0000
Subject: [PATCH 03/10] sh: dma: check return value of create_proc_read_entry()
Message-Id: <1280335166-23225-1-git-send-email-segooon@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Tejun Heo <tj@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

create_proc_read_entry() may fail, if so return -ENOMEM.

Signed-off-by: Kulikov Vasiliy <segooon@gmail.com>
---
 arch/sh/drivers/dma/dma-api.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 4a27722..f46848f 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -412,8 +412,8 @@ EXPORT_SYMBOL(unregister_dmac);
 static int __init dma_api_init(void)
 {
 	printk(KERN_NOTICE "DMA: Registering DMA API.\n");
-	create_proc_read_entry("dma", 0, 0, dma_read_proc, 0);
-	return 0;
+	return create_proc_read_entry("dma", 0, 0, dma_read_proc, 0)
+		    ? 0 : -ENOMEM;
 }
 subsys_initcall(dma_api_init);
 
-- 
1.7.0.4

