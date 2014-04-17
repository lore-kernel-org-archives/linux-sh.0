From: Brian Norris <computersforpeace@gmail.com>
Date: Thu, 17 Apr 2014 07:21:49 +0000
Subject: [PATCH 5/5] sh: defconfig: add MTD_SPI_NOR (new dependency for M25P80)
Message-Id: <1397719309-2022-6-git-send-email-computersforpeace@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Marek Vasut <marex@denx.de>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

This defconfig contain the CONFIG_M25P80 symbol, which is now
dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR.

At the same time, drop the now-nonexistent CONFIG_MTD_CHAR symbol.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
This change is based on l2-mtd.git/spinor, which is based on 3.15-rc1:

  git://git.infradead.org/l2-mtd.git +spinor

 arch/sh/configs/sh7757lcr_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index cfde98ddb29d..c5fda5636fd1 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -38,9 +38,9 @@ CONFIG_IPV6=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
1.8.3.2

