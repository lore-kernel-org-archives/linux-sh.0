From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 09 Oct 2014 02:09:00 +0000
Subject: [PATCH] dmaengine: shdma: fix a race condition in __ld_cleanup()
Message-Id: <1412820540-4892-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes a race condition about a list of shdma-base driver.
If we don't apply this patch, a dma slave driver (especially a usb
peripheral driver) may not be able to start the transfer.

If a dma slave driver has a callback, __ld_cleanup() will call
the callback before this driver removes the list. After the callback,
since the return value of __ld_cleanup() is not zero,
shdma_chan_ld_cleanup() calls __ld_cleanup() again. And, __ld_clean()
will removes the list.

At this time, if a dma slave driver calls dmaengine_submit() before
this driver removes the list, this driver will set schan->pm_state
to SHDMA_PM_PENDING in shdma_tx_submit(). And then, even if a dma
slave driver calls dma_async_issue_pending(), this driver don't
start the transfer because the schan->pm_state is SHDMA_PM_PENDING
in shdma_issue_pending().

So, this patch adds a new condition in __ld_clean() to check if the
schan->pm_state is SHDMA_PM_PENDING or not.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on slave-dma.git / next branch.
 (commit id : ade4a2a8e6e40fe18be1f83e5ea2e915692a0028)

 drivers/dma/sh/shdma-base.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 42d4974..2fd2f0ea 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -391,6 +391,8 @@ static dma_async_tx_callback __ld_cleanup(struct shdma_chan *schan, bool all)
 				dev_dbg(schan->dev, "Bring down channel %d\n", schan->id);
 				pm_runtime_put(schan->dev);
 				schan->pm_state = SHDMA_PM_ESTABLISHED;
+			} else if (schan->pm_state = SHDMA_PM_PENDING) {
+				shdma_chan_xfer_ld_queue(schan);
 			}
 		}
 	}
-- 
1.7.9.5

