From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 24 Nov 2010 09:48:10 +0000
Subject: [PATCH] dma: shdma: add a MODULE_ALIAS() to allow module autoloading
Message-Id: <Pine.LNX.4.64.1011241046380.18622@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index eb6b54d..85ffd5e 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1213,3 +1213,4 @@ module_exit(sh_dmae_exit);
 MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>");
 MODULE_DESCRIPTION("Renesas SH DMA Engine driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sh-dma-engine");
-- 
1.7.2.3

