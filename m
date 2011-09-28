From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Sep 2011 07:47:06 +0000
Subject: [PATCH] sh: pfc: Remove unused gpio_in_use member
Message-Id: <20110928074706.17605.82736.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Remove unused member gpio_in_use from struct pinmux_info.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 include/linux/sh_pfc.h |    1 -
 1 file changed, 1 deletion(-)

--- 0001/include/linux/sh_pfc.h
+++ work/include/linux/sh_pfc.h	2011-09-28 14:01:29.000000000 +0900
@@ -87,7 +87,6 @@ struct pinmux_info {
 	pinmux_enum_t *gpio_data;
 	unsigned int gpio_data_size;
 
-	unsigned long *gpio_in_use;
 	struct gpio_chip chip;
 };
 
