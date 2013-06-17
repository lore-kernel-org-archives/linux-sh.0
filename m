From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 17 Jun 2013 08:12:44 +0000
Subject: [PATCH 11/15] ARM: shmobile: Enable ARM_PATCH_PHYS_VIRT
Message-Id: <1371456768-1084-12-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1371456768-1084-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Adjust mach-shmobile to add a select for CONFIG_ARM_PATCH_PHYS_VIRT
and at the same time remove NEED_MACH_MEMORY_H.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index dfb4fee..f06e65b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -634,6 +634,7 @@ config ARCH_MSM
 
 config ARCH_SHMOBILE
 	bool "Renesas SH-Mobile / R-Mobile"
+	select ARM_PATCH_PHYS_VIRT
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
@@ -643,7 +644,6 @@ config ARCH_SHMOBILE
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select MULTI_IRQ_HANDLER
-	select NEED_MACH_MEMORY_H
 	select NO_IOPORT
 	select PINCTRL
 	select PM_GENERIC_DOMAINS if PM
-- 
1.7.10.4

