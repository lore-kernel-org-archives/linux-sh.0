From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Oct 2008 09:25:39 +0000
Subject: [PATCH] sh: use 10MHz VIO_CLK for ov772x on Migo-R
Message-Id: <20081022092539.1072.78186.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use a slower VIO_CKO clock frequency for the ov772x on Migo-R.
This improves the camera picture quality on Panel Board V2.1.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-22 12:43:18.000000000 +0900
@@ -288,8 +288,11 @@ static struct clk *camera_clk;
 
 static void camera_power_on(void)
 {
+	/* Use 10 MHz VIO_CKO instead of 24 MHz to work
+	 * around signal quality issues on Panel Board V2.1.
+	 */
 	camera_clk = clk_get(NULL, "video_clk");
-	clk_set_rate(camera_clk, 24000000);
+	clk_set_rate(camera_clk, 10000000);
 	clk_enable(camera_clk);	/* start VIO_CKO */
 
 	/* use VIO_RST to take camera out of reset */
