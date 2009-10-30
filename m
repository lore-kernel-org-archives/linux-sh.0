From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 06:26:04 +0000
Subject: [PATCH] sh: Remove unused WP signal for SDHI0 and KFR2R09
Message-Id: <20091030062604.22969.41725.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Get rid of the unused WP signal for SDHI0 on KFR2R09.
This because yc304 on KFR2R09 is a Micro SD slot which
does not implement the WP signal.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-kfr2r09/setup.c |    1 -
 1 file changed, 1 deletion(-)

--- 0013/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-10-30 14:51:33.000000000 +0900
@@ -539,7 +539,6 @@ static int __init kfr2r09_devices_setup(
 
 	/* SDHI0 connected to yc304 */
 	gpio_request(GPIO_FN_SDHI0CD, NULL);
-	gpio_request(GPIO_FN_SDHI0WP, NULL);
 	gpio_request(GPIO_FN_SDHI0D3, NULL);
 	gpio_request(GPIO_FN_SDHI0D2, NULL);
 	gpio_request(GPIO_FN_SDHI0D1, NULL);
