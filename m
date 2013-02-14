From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Feb 2013 13:49:20 +0000
Subject: [PATCH 04/11] ARM: shmobile: fix defconfig warning on CONFIG_USB
Message-Id: <1360849767-1463135-5-git-send-email-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

A recent update to the marzen_defconfig introduced a
duplicate CONFIG_USB=y line. This removes one of the
two.

arch/arm/configs/marzen_defconfig:86:warning: override: reassigning to symbol USB

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-sh@vger.kernel.org
---
 arch/arm/configs/marzen_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
index 728a43c..afb17d6 100644
--- a/arch/arm/configs/marzen_defconfig
+++ b/arch/arm/configs/marzen_defconfig
@@ -83,7 +83,6 @@ CONFIG_USB=y
 CONFIG_USB_RCAR_PHY=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHI=y
-CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
-- 
1.8.1.2

