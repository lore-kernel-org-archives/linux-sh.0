From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Sat, 02 Feb 2008 12:03:47 +0000
Subject: [PATCH] [SH] remove unneeded cast
Message-Id: <20080202230347.a126a143.sfr@canb.auug.org.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

now that platform_device_register_simple() takes a "const chat *".

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sh/drivers/dma/dma-api.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This hasn't even been built, but is straight forward.

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index 76ed816..727126e 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -350,7 +350,7 @@ int register_dmac(struct dma_info *info)
 
 	BUG_ON((info->flags & DMAC_CHANNELS_CONFIGURED) && !info->channels);
 
-	info->pdev = platform_device_register_simple((char *)info->name, -1,
+	info->pdev = platform_device_register_simple(info->name, -1,
 						     NULL, 0);
 	if (IS_ERR(info->pdev))
 		return PTR_ERR(info->pdev);
-- 
1.5.3.8



-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
