From: David Engraf <david.engraf@sysgo.com>
Date: Wed, 20 Jul 2011 13:03:39 +0000
Subject: [PATCH] shwdt: fix usage of mod_timer
Message-Id: <4E26D22B.1040702@sysgo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020705060108020003000904"
List-Id: <linux-sh.vger.kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

This is a multi-part message in MIME format.
--------------020705060108020003000904
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes the usage of mod_timer and makes the driver usable. 
mod_timer must be called with an absolute timeout in jiffies, the old 
implementation used a relative timeout thus the hardware watchdog was 
never triggered.

Signed-off-by: David Engraf <david.engraf@sysgo.com>



--------------020705060108020003000904
Content-Type: text/x-diff;
 name="shwdt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="shwdt.patch"

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index db84f23..a267dc0 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -64,7 +64,7 @@
  * misses its deadline, the kernel timer will allow the WDT to overflow.
  */
 static int clock_division_ratio = WTCSR_CKS_4096;
-#define next_ping_period(cks)	msecs_to_jiffies(cks - 4)
+#define next_ping_period(cks)	(jiffies + msecs_to_jiffies(cks - 4))
 
 static const struct watchdog_info sh_wdt_info;
 static struct platform_device *sh_wdt_dev;

--------------020705060108020003000904--
