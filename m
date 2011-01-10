From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Jan 2011 23:05:49 +0000
Subject: [PATCH] mmc, sh: Move MMCIF_PROGRESS_* into sh_mmcif.h
Message-Id: <20110110230549.GA20886@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Allow MMCIF_PROGRESS_* to be shared.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>
---
 arch/sh/boot/romimage/mmcif-sh7724.c |    3 ---
 include/linux/mmc/sh_mmcif.h         |    3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

Hi Paul,

this change didn't seem to make it into your
rc1 pull request, although it is present in
remotes/sh-2.6/common/mmcif.

It is needed by "[patch v5] mmc, ARM: Add zboot from MMC support for SuperH
Mobile ARM", which I was hoping to get Russell to merge post 2.6.38-rc1.
Perhaps I should just add the enums directly to
arch/arm/boot/compressed/mmcif-sh7372.c in that patch for now?

diff --git a/arch/sh/boot/romimage/mmcif-sh7724.c b/arch/sh/boot/romimage/mmcif-sh7724.c
index 14863d7..16b9c6f 100644
--- a/arch/sh/boot/romimage/mmcif-sh7724.c
+++ b/arch/sh/boot/romimage/mmcif-sh7724.c
@@ -21,9 +21,6 @@
 #define HIZCRC		0xa405015c
 #define DRVCRA		0xa405018a
 
-enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
-       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
-
 /* SH7724 specific MMCIF loader
  *
  * loads the romImage from an MMC card starting from block 512
diff --git a/include/linux/mmc/sh_mmcif.h b/include/linux/mmc/sh_mmcif.h
index ffabf8c..6a98e97 100644
--- a/include/linux/mmc/sh_mmcif.h
+++ b/include/linux/mmc/sh_mmcif.h
@@ -97,6 +97,9 @@ static inline void sh_mmcif_writel(void __iomem *addr, int reg, u32 val)
 
 #define SH_MMCIF_BBS 512 /* boot block size */
 
+enum { MMCIF_PROGRESS_ENTER, MMCIF_PROGRESS_INIT,
+       MMCIF_PROGRESS_LOAD, MMCIF_PROGRESS_DONE };
+
 static inline void sh_mmcif_boot_cmd_send(void __iomem *base,
 					  unsigned long cmd, unsigned long arg)
 {
-- 
1.7.2.3
