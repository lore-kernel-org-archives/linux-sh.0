From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Tue, 05 Feb 2019 19:37:42 +0000
Subject: [PATCH] sh: migor: Include missing dma-mapping header
Message-Id: <20190205193742.24940-1-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hverkuil@xs4all.nl, mchehab@kernel.org, linux-media@vger.kernel.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Since the removal of the stale soc_camera headers, Migo-R board fails to
build due to missing dma-mapping include directive.

Include missing dma-mapping.h header in Migo-R board file to fix the build
error.

Fixes: a50c7738e8ae ("media: sh: migor: Remove stale soc_camera include")
Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
Hans pointed me to this error quite some time ago, but it took me a kbuild
error to address this. Sorry for the delay.

Again, should this go through media as this is caused by soc_camera related
churn?

Thanks
  j

---
 arch/sh/boards/mach-migor/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index f4ad33c6d2aa..1d2993bdd231 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Magnus Damm
  */
 #include <linux/clkdev.h>
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
--
2.20.1
