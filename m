From: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
Date: Mon, 06 Apr 2015 03:50:41 +0000
Subject: [RFC/PATCH 1/4] ARM: cpuidle: Add cpuidle support for R-Car Gen2 series
Message-Id: <1428292244-2160-2-git-send-email-keita.kobayashi.ym@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
In-Reply-To: <1428292244-2160-1-git-send-email-keita.kobayashi.ym@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, Keita Kobayashi <keita.kobayashi.ym@renesas.com>

Define ARM_RCAR_CPUIDLE config item to enable cpuidle
support for Renesas R-Car Gen2 SoCs.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 drivers/cpuidle/Kconfig.arm | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 21340e0..ea9d61e 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -74,3 +74,11 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU && !ARM64
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_RCAR_CPUIDLE
+	bool "CPU Idle Driver for the R-Car SoCs"
+	depends on ARCH_RCAR_GEN2
+	select ARM_CPUIDLE
+	select ARM_CPU_SUSPEND
+	help
+	  Select this to enable cpuidle for R-Car SoCs
-- 
1.9.1

