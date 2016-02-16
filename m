From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 16 Feb 2016 15:31:50 +0000
Subject: [PATCH 2/4] arm64: renesas: Enable PM and PM_GENERIC_DOMAINS for SoCs with PM Domains
Message-Id: <1455636712-3040-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1455636712-3040-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

All supported Renesas ARM64 SoCs have clock and power domains. To ensure
proper operation of on-SoC modules, module clocks must be ungated, and
power domains must be powered up when needed.

Currently the user can choose to build a kernel with power management
enabled or disabled:
  - If CONFIG_PM=y, power domains and/or module clocks are handled
    dynamically by Runtime PM and the generic power domain.
  - If CONFIG_PM=n, power domains are assumed to be powered up by reset
    state or by the boot loader, and module clocks are handled by the
    legacy clock domain on driver (un)bind.
    The latter is implemented using a platform bus notifier, which
    applies not only to all on-SoC devices, but to all platform devices
    present in the system.

To remove the dependency on implicit assumptions, and to get rid of the
peculiarities of the legacy clock domain, enable CONFIG_PM and
CONFIG_PM_GENERIC_DOMAINS unconditionally.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/Kconfig.platforms | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f674bdeb707..2c0caac053e8c12a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -76,7 +76,8 @@ config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
 	select ARCH_SHMOBILE
 	select PINCTRL
-	select PM_GENERIC_DOMAINS if PM
+	select PM
+	select PM_GENERIC_DOMAINS
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-- 
1.9.1

