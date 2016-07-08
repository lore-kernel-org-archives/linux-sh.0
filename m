From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 08 Jul 2016 16:43:45 +0000
Subject: [PATCH] sh: sh03_defconfig: disable IDE subsystem
Message-Id: <1467996225-25498-6-git-send-email-b.zolnierkie@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1467996225-25498-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com

This patch disables deprecated IDE subsystem in sh03_defconfig
(no IDE host drivers are selected in this config so there is no
valid reason to enable IDE subsystem itself).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/sh/configs/sh03_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index 0cf4097..b2ab7490 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -43,9 +43,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=m
-CONFIG_BLK_DEV_IDETAPE=m
 CONFIG_SCSI=m
 CONFIG_BLK_DEV_SD=m
 CONFIG_BLK_DEV_SR=m
-- 
1.9.1

