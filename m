From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 09 Feb 2008 12:14:05 +0000
Subject: [PATCH] Dreamcast - fix spelling
Message-Id: <1202559245.6282.1.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the spelling in a variable name.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>

==

diff --git a/include/linux/maple.h b/include/linux/maple.h
index 35c3474..34578c2 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -39,7 +39,7 @@ struct maple_devinfo {
 	unsigned long function;
 	unsigned long function_data[3];
 	unsigned char area_code;
-	unsigned char connector_directon;
+	unsigned char connector_direction;
 	char product_name[31];
 	char product_licence[61];
 	unsigned short standby_power;

