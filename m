From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 21 Oct 2008 12:31:07 +0000
Subject: [PATCH] sh: Update gpio_set_value() pin value handling
Message-Id: <20081021123107.27891.40895.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch updates the pinmux code to use the boolean value for
the function gpio_set_value(). Without this patch values other
than 0 and 1 will result in incorrect GPIO settings.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/sh/kernel/gpio.c
+++ work/arch/sh/kernel/gpio.c	2008-10-21 20:22:25.000000000 +0900
@@ -432,7 +432,7 @@ static int __gpio_get_set_value(struct p
 		BUG();
 	else
 		value = read_write_reg(dr->reg, dr->reg_width,
-				       1, bit, value, do_write);
+				       1, bit, !!value, do_write);
 
 	return value;
 }
