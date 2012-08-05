From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 05 Aug 2012 01:54:05 +0000
Subject: [PATCH] sh: dma: fix request_irq usage
Message-Id: <1344131645-10813-1-git-send-email-vapier@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When calling request_irq with IRQF_SHARED, the dev cookie must be set
(i.e. non-NULL), otherwise the code rejects it immediately with -EINVAL.
So restore the logic here where we'd pass a pointer to the name as a
dummy unique val.

Otherwise, booting up on my LANDISK system would fail with:
	DMAC Address Error0 request_irq fail

This was introduced in commit 7f47c7189b3e8f19a589f77a3ad169d7b691b582.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 arch/sh/drivers/dma/dma-sh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 4c171f1..b225656 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -335,7 +335,7 @@ static int dmae_irq_init(void)
 
 	for (n = 0; n < NR_DMAE; n++) {
 		int i = request_irq(get_dma_error_irq(n), dma_err,
-				    IRQF_SHARED, dmae_name[n], NULL);
+				    IRQF_SHARED, dmae_name[n], (void *)dmae_name[n]);
 		if (unlikely(i < 0)) {
 			printk(KERN_ERR "%s request_irq fail\n", dmae_name[n]);
 			return i;
-- 
1.7.9.7

