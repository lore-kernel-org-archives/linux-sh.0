From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 16 Feb 2008 23:37:33 +0000
Subject: [PATCH] maple: remove unused variable
Message-Id: <1203205053.6737.17.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>
Cc: LKML <linux-kernel@vger.kernel.org>

Remove an unused variable from the definition of struct maple_device

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff -ruN a/include/linux/maple.h b/include/linux/maple.h
--- a/include/linux/maple.h	2008-02-16 20:52:09.000000000 +0000
+++ b/include/linux/maple.h	2008-02-16 21:42:06.000000000 +0000
@@ -64,7 +64,6 @@
 	int (*connect) (struct maple_device * dev);
 	void (*disconnect) (struct maple_device * dev);
 	struct device_driver drv;
-	int registered;
 };
 


