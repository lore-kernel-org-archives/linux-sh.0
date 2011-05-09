From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 09 May 2011 03:51:29 +0000
Subject: [PATCH] sh_mobile: Use SYSC.RESCNT2 to perform soft reboot
Message-Id: <1304913089-10173-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Use the Soft Power On Reset to reset the CPU instead of cpu_reset.
This allows for the system to properly reboot from a 'shutdown' or
'reboot' command.
---
 arch/arm/mach-shmobile/include/mach/system.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/system.h b/arch/arm/mach-shmobile/include/mach/system.h
index 76a687e..6dde0b7 100644
--- a/arch/arm/mach-shmobile/include/mach/system.h
+++ b/arch/arm/mach-shmobile/include/mach/system.h
@@ -1,6 +1,9 @@
 #ifndef __ASM_ARCH_SYSTEM_H
 #define __ASM_ARCH_SYSTEM_H
 
+#define RESCNT2 0xE6188020
+#define PRES (1 << 31)
+
 static inline void arch_idle(void)
 {
 	cpu_do_idle();
@@ -8,7 +11,7 @@ static inline void arch_idle(void)
 
 static inline void arch_reset(char mode, const char *cmd)
 {
-	cpu_reset(0);
+	__raw_writel(__raw_readl(RESCNT2) | PRES, RESCNT2);
 }
 
 #endif
-- 
1.7.1

