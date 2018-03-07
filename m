From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 07 Mar 2018 11:15:14 +0000
Subject: [PATCH 2/2] sh: superhyway: use put_device() if device_register fail
Message-Id: <ea06f4581b63ebdbb7c9e8739780181f53a9c774.1520420267.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

if device_register() returned an error! Always use put_device()
to give up the reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/sh/superhyway/superhyway.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/superhyway/superhyway.c b/drivers/sh/superhyway/superhyway.c
index 348836b..98922e7 100644
--- a/drivers/sh/superhyway/superhyway.c
+++ b/drivers/sh/superhyway/superhyway.c
@@ -54,6 +54,7 @@ int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
 			  struct superhyway_bus *bus)
 {
 	struct superhyway_device *dev = sdev;
+	int ret;
 
 	if (!dev) {
 		dev = kzalloc(sizeof(struct superhyway_device), GFP_KERNEL);
@@ -87,7 +88,11 @@ int superhyway_add_device(unsigned long base, struct superhyway_device *sdev,
 
 	superhyway_devices++;
 
-	return device_register(&dev->dev);
+	ret = device_register(&dev->dev);
+	if (ret)
+		put_device(&dev->dev);
+
+	return ret;
 }
 
 int superhyway_add_devices(struct superhyway_bus *bus,
@@ -110,8 +115,10 @@ static int __init superhyway_init(void)
 	int ret;
 
 	ret = device_register(&superhyway_bus_device);
-	if (unlikely(ret))
+	if (unlikely(ret)) {
+		put_device(&superhyway_bus_device);
 		return ret;
+	}
 
 	for (bus = superhyway_channels; bus->ops; bus++)
 		ret |= superhyway_scan_bus(bus);
-- 
1.9.1

