From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 04 Apr 2013 07:46:44 +0000
Subject: [RFC/PATCH 8/7] ARCH: shmobile: defconfig consolidation (repost)
Message-Id: <1365061604-24808-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365046193-19369-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig |    2 ++
 1 file changed, 2 insertions(+)

Reposted with correct In-Reply-To header (hopefully!)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 9b6219a..7dba53f 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -14,9 +14,11 @@ CONFIG_SLAB=y
 CONFIG_ARCH_SHMOBILE=y
 CONFIG_ARCH_SH7372=y
 CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7790=y
 CONFIG_ARCH_EMEV2=y
 CONFIG_MACH_MACKEREL=y
 CONFIG_MACH_ARMADILLO800EVA=y
+CONFIG_MACH_LAGER=y
 CONFIG_MACH_KZM9D=y
 # CONFIG_SH_TIMER_TMU is not set
 # CONFIG_SWP_EMULATE is not set
-- 
1.7.10.4

