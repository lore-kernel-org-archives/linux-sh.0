From: Rob Herring <robherring2@gmail.com>
Date: Fri, 20 Jan 2012 20:33:11 +0000
Subject: [PATCH v2 13/13] ARM: picoxcell: remove mach/irqs.h
Message-Id: <1327091591-27125-14-git-send-email-robherring2@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Jamie Iles <jamie@jamieiles.com>

picoxcell uses SPARSE_IRQ which means we don't need a mach/irqs.h
anymore so kill it off.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-picoxcell/include/mach/irqs.h |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h

diff --git a/arch/arm/mach-picoxcell/include/mach/irqs.h b/arch/arm/mach-picoxcell/include/mach/irqs.h
deleted file mode 100644
index 59eac1e..0000000
--- a/arch/arm/mach-picoxcell/include/mach/irqs.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __MACH_IRQS_H
-#define __MACH_IRQS_H
-
-/* We dynamically allocate our irq_desc's. */
-#define NR_IRQS				0
-
-#endif /* __MACH_IRQS_H */
-- 
1.7.5.4

