From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 21 Oct 2008 12:29:03 +0000
Subject: [PATCH] sh: update ov772x byte order on Migo-R
Message-Id: <20081021122903.27876.33583.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Update the ov772x byte sequence to enable byte swap. This to reflect
the recent CEU driver change to follow incoming byte order.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2008-10-21 15:04:44.000000000 +0900
@@ -318,7 +318,7 @@ static void camera_power(int mode)
 #ifdef CONFIG_I2C
 static unsigned char camera_ov772x_magic[]  {
-	0x09, 0x01, 0x0c, 0x10, 0x0d, 0x41, 0x0e, 0x01,
+	0x09, 0x01, 0x0c, 0x20, 0x0d, 0x41, 0x0e, 0x01,
 	0x12, 0x00, 0x13, 0x8F, 0x14, 0x4A, 0x15, 0x00,
 	0x16, 0x00, 0x17, 0x23, 0x18, 0xa0, 0x19, 0x07,
 	0x1a, 0xf0, 0x1b, 0x40, 0x1f, 0x00, 0x20, 0x10,
