From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 10 Apr 2014 22:59:42 +0000
Subject: [PATCH] phy: fix kernel oops in phy_lookup()
Message-Id: <201404110259.43282.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kishon@ti.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, linux-kernel@vger.kernel.org

The kernel oopses in phy_lookup() due to 'phy->init_data' being NULL if we
register PHYs from a device tree probing driver and then call phy_get() on a
device that has no representation in the device tree (e.g. a PCI device).
Checking the pointer before dereferening it and skipping an interation if
it's NULL prevents this kernel oops.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'fixes' branch of Kishon's 'linux-phy.git' repo.

 drivers/phy/phy-core.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-phy/drivers/phy/phy-core.c
=================================--- linux-phy.orig/drivers/phy/phy-core.c
+++ linux-phy/drivers/phy/phy-core.c
@@ -64,6 +64,9 @@ static struct phy *phy_lookup(struct dev
 	class_dev_iter_init(&iter, phy_class, NULL, NULL);
 	while ((dev = class_dev_iter_next(&iter))) {
 		phy = to_phy(dev);
+
+		if (!phy->init_data)
+			continue;
 		count = phy->init_data->num_consumers;
 		consumers = phy->init_data->consumers;
 		while (count--) {
