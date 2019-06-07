From: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Date: Fri, 07 Jun 2019 11:54:03 +0000
Subject: [PATCH] sh: dma: Add missing IS_ERR test
Message-Id: <20190607115404.4557-1-embedded24@evers-fischer.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rolf Evers-Fischer <embedded24@evers-fischer.de>

get_dma_channel may return ERR_PTR, so a check is added.

Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 arch/sh/drivers/dma/dma-api.c   | 20 +++++++++++++++++++-
 arch/sh/drivers/dma/dma-sysfs.c |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index ab9170494dcc..5d6f1a46cc5e 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
-	if (info->ops->get_residue)
+	if (!IS_ERR(channel) && (info->ops->get_residue))
 		return info->ops->get_residue(channel);
 
 	return 0;
@@ -195,6 +195,9 @@ int request_dma(unsigned int chan, const char *dev_id)
 	int result;
 
 	channel = get_dma_channel(chan);
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
 	if (atomic_xchg(&channel->busy, 1))
 		return -EBUSY;
 
@@ -217,6 +220,9 @@ void free_dma(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return;
+
 	if (info->ops->free)
 		info->ops->free(channel);
 
@@ -229,6 +235,9 @@ void dma_wait_for_completion(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return;
+
 	if (channel->flags & DMA_TEI_CAPABLE) {
 		wait_event(channel->wait_queue,
 			   (info->ops->get_residue(channel) = 0));
@@ -274,6 +283,9 @@ void dma_configure_channel(unsigned int chan, unsigned long flags)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return;
+
 	if (info->ops->configure)
 		info->ops->configure(channel, flags);
 }
@@ -285,6 +297,9 @@ int dma_xfer(unsigned int chan, unsigned long from,
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
 	channel->sar	= from;
 	channel->dar	= to;
 	channel->count	= size;
@@ -299,6 +314,9 @@ int dma_extend(unsigned int chan, unsigned long op, void *param)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR(channel))
+		return PTR_ERR(channel);
+
 	if (info->ops->extend)
 		return info->ops->extend(channel, op, param);
 
diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 8ef318150f84..6ba5b569d446 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -30,7 +30,7 @@ static ssize_t dma_show_devices(struct device *dev,
 		struct dma_info *info = get_dma_info(i);
 		struct dma_channel *channel = get_dma_channel(i);
 
-		if (unlikely(!info) || !channel)
+		if (unlikely(!info) || IS_ERR_OR_NULL(channel))
 			continue;
 
 		len += sprintf(buf + len, "%2d: %14s    %s\n",
-- 
2.21.0
