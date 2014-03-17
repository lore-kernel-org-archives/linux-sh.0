From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:15:17 +0000
Subject: [RFC 6/6] ARM: shmobile: change to use platformbus_pm_runtime_init
Message-Id: <1395054917-27390-7-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

---
 arch/arm/mach-shmobile/include/mach/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 4727d4f..0ba234b 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -52,6 +52,6 @@ static inline void __init shmobile_init_late(void)
 	shmobile_cpuidle_init();
 }
 
-extern int sh_pm_runtime_init(void);
+#define sh_pm_runtime_init platformbus_pm_runtime_init
 
 #endif /* __ARCH_MACH_COMMON_H */
-- 
1.9.0

