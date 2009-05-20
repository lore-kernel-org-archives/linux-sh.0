From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 May 2009 14:30:06 +0000
Subject: [PATCH] sh: ap325 camera without i2c driver fix
Message-Id: <20090520143006.8314.55548.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch fixes the ap325rxa ncm03j camera code to handle
the case where no i2c driver is present. Without this fix
i2c_transfer() may be passed NULL as adapter which results
in a crash.

Triggered when i2c-sh_mobile.c failed to probe() due to
missing MSTP clocks.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2009-05-20 22:25:41.000000000 +0900
@@ -263,6 +263,9 @@ static int camera_probe(void)
 	struct i2c_msg msg;
 	int ret;
 
+	if (!a)
+		return -ENODEV;
+
 	camera_power(1);
 	msg.addr = 0x6e;
 	msg.buf = camera_ncm03j_magic;
