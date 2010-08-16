From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Aug 2010 10:40:49 +0000
Subject: [PATCH] ARM: mach-shmobile: Clock framework comment fix
Message-Id: <20100816104049.32610.51263.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update clock framework header comment for SH-Mobile ARM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/clock.c
+++ work/arch/arm/mach-shmobile/clock.c	2010-08-16 14:41:31.000000000 +0900
@@ -1,8 +1,10 @@
 /*
- * SH-Mobile Timer
+ * SH-Mobile Clock Framework
  *
  * Copyright (C) 2010  Magnus Damm
  *
+ * Used together with arch/arm/common/clkdev.c and drivers/sh/clk.c.
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; version 2 of the License.
