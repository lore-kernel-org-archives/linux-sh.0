From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 31 May 2013 03:00:27 +0000
Subject: [PATCH] Revert "ARM: shmobile: Disallow PINCTRL without GPIOLIB"
Message-Id: <1369969227-11742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

GPIOLIB dependency handling was added to the PINCTRL core by

commit 2afe8229687ec24cbc07e78449a588bb8b68f858
Author: Haojian Zhuang <haojian.zhuang@linaro.org>
Date:   Thu Mar 28 07:34:19 2013 +0800

    pinctrl: core: add dependence of GPIOLIB

There is not need to handle that dependency at the SH Mobile level
anymore. Revert

commit 6722f6cb763203cab775297b6e9d00834af0d6d7
Author: Magnus Damm <damm@opensource.se>
Date:   Mon Mar 18 22:58:18 2013 +0900

    ARM: shmobile: Disallow PINCTRL without GPIOLIB

    Modify mach-shmobile to only select PINCTRL in case of
    ARCH_WANT_OPTIONAL_GPIOLIB is set.

    This fixes a build error triggered when adding a new SoC
    lacking GPIO software support (ARCH_WANT_OPTIONAL_GPIOLIB=n):

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

The patch has been tested by hacking arch/arm/mach-shmobile/Kconfig to remove
ARCH_WANT_OPTIONAL_GPIOLIB selection from ARCH_EMEV2. The kernel then compiles
fine with PINCTRL enabled and GPIOLIB disabled.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..dfb4fee 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -645,7 +645,7 @@ config ARCH_SHMOBILE
 	select MULTI_IRQ_HANDLER
 	select NEED_MACH_MEMORY_H
 	select NO_IOPORT
-	select PINCTRL if ARCH_WANT_OPTIONAL_GPIOLIB
+	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
 	select SPARSE_IRQ
 	help
-- 
Regards,

Laurent Pinchart

