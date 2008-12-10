From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Dec 2008 08:02:13 +0000
Subject: [PATCH] sh: add ov772x reset delay on Migo-R
Message-Id: <20081210080213.5789.69039.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add reset delay for the ov772x device on Migo-R.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Applies on top of Morimoto-sans ov772x patches.

 arch/sh/boards/mach-migor/setup.c |    1 +
 1 file changed, 1 insertion(+)

--- 0032/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-12-10 12:41:02.000000000 +0900
@@ -301,6 +301,7 @@ static void camera_power_on(void)
 	gpio_set_value(GPIO_PTT3, 0);
 	mdelay(10);
 	gpio_set_value(GPIO_PTT3, 1);
+	mdelay(10); /* wait to let chip come out of reset */
 }
 
 static void camera_power_off(void)
