From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 15 Jun 2008 19:48:09 +0000
Subject: [PATCH] maple: tidy  maple_driver code by removing redundant
Message-Id: <1213559289.22707.15.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

The connect and disconnect functions are unnecessary - everything they do can be
accomplished in the initial probe - so remove them.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 39a125a..d49e2d3 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -62,8 +62,6 @@ struct maple_device {
 
 struct maple_driver {
 	unsigned long function;
-	int (*connect) (struct maple_device * dev);
-	void (*disconnect) (struct maple_device * dev);
 	struct device_driver drv;
 };

