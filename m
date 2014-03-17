From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:15:15 +0000
Subject: [RFC 4/6] ARM: shmobile: r8a7790: call sh_pm_runtime_init()
Message-Id: <1395054917-27390-5-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Ensure pm_runtime is initialised.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index c4616f0..8424cb4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -305,6 +305,7 @@ void __init r8a7790_add_dt_devices(void)
 
 void __init r8a7790_add_standard_devices(void)
 {
+	sh_pm_runtime_init();
 	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
-- 
1.9.0

