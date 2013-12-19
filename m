From: Levente Kurusa <levex@linux.com>
Date: Thu, 19 Dec 2013 15:03:12 +0000
Subject: [PATCH 01/38] sh: dma-sysfs: add missing put_device call
Message-Id: <1387465429-3568-2-git-send-email-levex@linux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/sh/drivers/dma/dma-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 4b15fed..76271e6 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -131,8 +131,10 @@ int dma_create_sysfs_files(struct dma_channel *chan, struct dma_info *info)
 	dev->bus = &dma_subsys;
 
 	ret = device_register(dev);
-	if (ret)
+	if (ret) {
+		put_device(dev);
 		return ret;
+	}
 
 	ret |= device_create_file(dev, &dev_attr_dev_id);
 	ret |= device_create_file(dev, &dev_attr_count);
-- 
1.8.3.1

