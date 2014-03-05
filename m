From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 05 Mar 2014 18:43:45 +0000
Subject: [PATCH trivial] irq-gic: remove file name from heading comment
Message-Id: <201403052243.46123.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

File names in the heading comments  fell out of favor long ago, and this one
weren't even changed when the driver was moved from arch/arm/common/, so remove
it at last...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'for-next' branch of the 'trivial.git' repo.
Thomas Gleixner has told me to send the patch to this tree instead of his one.

 drivers/irqchip/irq-gic.c |    2 --
 1 file changed, 2 deletions(-)

Index: trivial/drivers/irqchip/irq-gic.c
=================================--- trivial.orig/drivers/irqchip/irq-gic.c
+++ trivial/drivers/irqchip/irq-gic.c
@@ -1,6 +1,4 @@
 /*
- *  linux/arch/arm/common/gic.c
- *
  *  Copyright (C) 2002 ARM Limited, All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify
