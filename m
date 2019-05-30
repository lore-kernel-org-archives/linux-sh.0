From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Thu, 30 May 2019 02:10:32 +0000
Subject: [PATCH] sh: configs: remove CONFIG_LOGFS from defconfig
Message-Id: <20190530021032.190639-1-wangkefeng.wang@huawei.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>

After commit 1d0fd57a50aa ("logfs: remove from tree"),
logfs was removed, drop CONFIG_LOGFS from all defconfigs.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sh/configs/sdk7786_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 5209889765ad..49a29338789b 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -191,7 +191,6 @@ CONFIG_CONFIGFS_FS=y
 CONFIG_JFFS2_FS=m
 CONFIG_JFFS2_FS_XATTR=y
 CONFIG_UBIFS_FS=m
-CONFIG_LOGFS=m
 CONFIG_CRAMFS=m
 CONFIG_SQUASHFS=m
 CONFIG_ROMFS_FS=m
-- 
2.20.1
