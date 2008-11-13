From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 13 Nov 2008 06:28:21 +0000
Subject: [PATCH] i2c: fix i2c-sh_mobile rx underrun
Message-Id: <20081113062821.4993.30076.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix receive path underrun in i2c-sh_mobile driver. 

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Paul, can you include this with your other SuperH changes for 2.6.28?

 drivers/i2c/busses/i2c-sh_mobile.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2008-11-11 19:22:49.000000000 +0900
@@ -318,7 +318,8 @@ static int sh_mobile_i2c_isr_rx(struct s
 		} else
 			data = i2c_op(pd, OP_RX, 0);
 
-		pd->msg->buf[real_pos] = data;
+		if (real_pos >= 0)
+			pd->msg->buf[real_pos] = data;
 	} while (0);
 
 	pd->pos++;
