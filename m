From: Levente Kurusa <levex@linux.com>
Date: Thu, 19 Dec 2013 15:03:38 +0000
Subject: [PATCH 27/38] superhyway: add missing put_device call
Message-Id: <1387465429-3568-28-git-send-email-levex@linux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This is required so that we give up the last reference to the device.
Also, this makes superhyway_device_release actually used.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 drivers/sh/superhyway/superhyway.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
index 2d9e7f3..765cf7d 100644
--- a/drivers/sh/superhyway/superhyway.c
+++ b/drivers/sh/superhyway/superhyway.c
@@ -54,6 +54,7 @@ int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
 			  struct superhyway_bus *bus)
 {
 	struct superhyway_device *dev = sdev;
+	int rc = 0;
 
 	if (!dev) {
 		dev = kzalloc(sizeof(struct superhyway_device), GFP_KERNEL);
@@ -86,8 +87,11 @@ int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
 	dev_set_name(&dev->dev, "%02x", superhyway_devices);
 
 	superhyway_devices++;
+	rc = device_register(&dev->dev);
+	if (rc)
+		put_device(&dev->dev);
 
-	return device_register(&dev->dev);
+	return rc;
 }
 
 int superhyway_add_devices(struct superhyway_bus *bus,
-- 
1.8.3.1

