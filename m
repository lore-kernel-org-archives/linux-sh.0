From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:02:10 +0000
Subject: [PATCH v2 11/77] ARM: shmobile: Select PINCTRL
Message-Id: <1353974596-30033-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The pin control framework is required by mach-shmobile. Select it in
Kconfig.

This will be required when the sh-pfc driver will move to
drivers/pinctrl/.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..3eaa434 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -693,6 +693,7 @@ config ARCH_SHMOBILE
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select NO_IOPORT
+	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
 	select SPARSE_IRQ
 	help
-- 
1.7.8.6

