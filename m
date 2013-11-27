From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Nov 2013 01:18:37 +0000
Subject: [PATCH 15/15] sh: intc: Enable driver compilation with COMPILE_TEST
Message-Id: <1385515117-23664-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This helps increasing build testing coverage.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/sh/intc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/Kconfig b/drivers/sh/intc/Kconfig
index a305731..f7d9061 100644
--- a/drivers/sh/intc/Kconfig
+++ b/drivers/sh/intc/Kconfig
@@ -6,7 +6,7 @@ comment "Interrupt controller options"
 
 config INTC_USERIMASK
 	bool "Userspace interrupt masking support"
-	depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A)
+	depends on ARCH_SHMOBILE || (SUPERH && CPU_SH4A) || COMPILE_TEST
 	help
 	  This enables support for hardware-assisted userspace hardirq
 	  masking.
-- 
1.8.3.2

