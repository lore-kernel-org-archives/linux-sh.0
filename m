From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Date: Fri, 01 Aug 2014 09:49:01 +0000
Subject: [PATCH 6/6] ARM: shmobile: Enable CPUIdle configuration for shmobile_defconfig
Message-Id: <53DB628D.4000900@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
Cc: horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, rjw@rjwysocki.net

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/configs/shmobile_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3b13614..63e57a5 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -149,6 +149,8 @@ CONFIG_NLS_ISO8859_1=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_SHMOBILE_CPUIDLE=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_COMMON=y
 CONFIG_CPU_FREQ_STAT=y
-- 
1.7.9.5
