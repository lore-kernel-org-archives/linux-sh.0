From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Date: Wed, 04 Mar 2015 04:55:46 +0000
Subject: [RFC/PATCH 6/6] ARM: shmobile: Enable Renesas CPUIdle for shmobile_defconfig
Message-Id: <1425444946-3084-7-git-send-email-keita.kobayashi.ym@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
In-Reply-To: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, rjw@rjwysocki.net
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/configs/shmobile_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 1155415..da7fa03 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -43,6 +43,8 @@ CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
 CONFIG_CPUFREQ_DT=y
+CONFIG_CPU_IDLE=y
+CONFIG_ARM_RENESAS_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-- 
1.9.1

