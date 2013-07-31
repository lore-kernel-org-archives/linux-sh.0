From: Chen Gang <gang.chen@asianux.com>
Date: Wed, 31 Jul 2013 07:23:31 +0000
Subject: [PATCH] sh: kernel: cpu: provide 'NULL' parameter for calling cpuidle_register().
Message-Id: <51F8BB73.2070603@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Need provide additional parameter for calling cpuidle_register() just
like some of another architectures have done, or can not pass compiling.

The related error (with kfr2r09_defconfig):

    CC      arch/sh/kernel/cpu/shmobile/cpuidle.o
  arch/sh/kernel/cpu/shmobile/cpuidle.c: In function 'sh_mobile_setup_cpuidle':
  arch/sh/kernel/cpu/shmobile/cpuidle.c:102:2: error: too few arguments to function 'cpuidle_register'
    return cpuidle_register(&cpuidle_driver);
    ^
  In file included from arch/sh/kernel/cpu/shmobile/cpuidle.c:16:0:
  include/linux/cpuidle.h:130:12: note: declared here
   extern int cpuidle_register(struct cpuidle_driver *drv,
            ^

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index d306225..5f88393 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -99,5 +99,5 @@ int __init sh_mobile_setup_cpuidle(void)
 	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY)
 		cpuidle_driver.states[2].disabled = false;
 
-	return cpuidle_register(&cpuidle_driver);
+	return cpuidle_register(&cpuidle_driver, NULL);
 }
-- 
1.7.7.6
