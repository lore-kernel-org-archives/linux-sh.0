From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 07 Mar 2018 11:15:13 +0000
Subject: [PATCH 1/2] sh: maple: use put_device() instead of kfree()
Message-Id: <ca808c5980d1ceaab59b5798e46e994a9c150b24.1520420267.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/sh/maple/maple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index 7525039..28674fe 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -393,7 +393,7 @@ static void maple_attach_driver(struct maple_device *mdev)
 		dev_warn(&mdev->dev, "could not register device at"
 			" (%d, %d), with error 0x%X\n", mdev->unit,
 			mdev->port, error);
-		maple_free_dev(mdev);
+		put_device(&mdev->dev);
 		mdev = NULL;
 		return;
 	}
@@ -886,6 +886,7 @@ static int __init maple_bus_init(void)
 
 cleanup:
 	printk(KERN_ERR "Maple bus registration failed\n");
+	put_device(&maple_bus);
 	return retval;
 }
 /* Push init to later to ensure hardware gets detected */
-- 
1.9.1

