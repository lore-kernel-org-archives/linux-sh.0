From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 04 Aug 2015 18:03:12 +0000
Subject: [PATCH 7/7] ARM: shmobile: Remove obsolete twd_local_timer declaration
Message-Id: <1438711392-23763-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1438711392-23763-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The last user of twd_local_timer was removed in commit c99cd90d98a98aa1
("ARM: shmobile: r8a7779: Remove legacy SoC code").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 2a350b48b893a1b6..0833a6ed02e4a127 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -2,7 +2,6 @@
 #define __ARCH_MACH_COMMON_H
 
 extern void shmobile_init_delay(void);
-struct twd_local_timer;
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
-- 
1.9.1

