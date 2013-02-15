From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 15 Feb 2013 13:00:57 +0000
Subject: [PATCH 1/5] ARM: shmobile: kzm9g: defconfig: do not enable PREEMPT
Message-Id: <1360933261-6359-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The motivation for this change is:

* It is consistent with all other shmobile boards and;
* Allows the kzm9g-reference code to work with CONFIG_SMP
  and thus the new defconfig

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kzm9g_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
index afbae28..da7672e 100644
--- a/arch/arm/configs/kzm9g_defconfig
+++ b/arch/arm/configs/kzm9g_defconfig
@@ -33,7 +33,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
-CONFIG_PREEMPT=y
 CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_HIGHMEM=y
-- 
1.7.10.4

