From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:15:14 +0000
Subject: [RFC 3/6] ARM: shmobile: add sh_pm_runtime_init() to header
Message-Id: <1395054917-27390-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add definition of sh_pm_runtime_init() to machine header to allow calling
the pm_runtime initialisation code.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-shmobile/include/mach/common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index cb8e32d..4727d4f 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -52,4 +52,6 @@ static inline void __init shmobile_init_late(void)
 	shmobile_cpuidle_init();
 }
 
+extern int sh_pm_runtime_init(void);
+
 #endif /* __ARCH_MACH_COMMON_H */
-- 
1.9.0

