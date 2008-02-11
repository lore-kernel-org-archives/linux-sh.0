From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 11 Feb 2008 00:25:02 +0000
Subject: [PATCH] SH/Dreamcast - improve detection of attached peripherals
Message-Id: <1202689502.6237.23.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Improve device detection for maple through longer delay

Experience suggests that a much longer delay in setting up the Maple bus
on the Dreamcast leads to better hardware detection.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

-----

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index fbca7f8..afb5362 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -658,7 +658,6 @@ static int __init maple_bus_init(void)
 		goto cleanup_device;
 
 	retval = driver_register(&maple_dummy_driver.drv);
-
 	if (retval)
 		goto cleanup_bus;
 
@@ -704,7 +703,7 @@ static int __init maple_bus_init(void)
 		mdev[i]->mq->length = 0;
 		maple_add_packet(mdev[i]->mq);
 		/* delay aids hardware detection */
-		udelay(20);
+		mdelay(5);
 		subdevice_map[i] = 0;
 	}
 

