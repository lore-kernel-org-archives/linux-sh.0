From: Peter De Schrijver <pdeschrijver@nvidia.com>
Date: Thu, 03 Nov 2011 17:00:46 +0000
Subject: [PATCH 2/3] ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
Message-Id: <1320339647-30255-3-git-send-email-pdeschrijver@nvidia.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
In-Reply-To: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add default value for CONFIG_ARCH_NR_GPIO to Kconfig and remove the definition
in gpio.h.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/Kconfig                           |    2 +-
 arch/arm/mach-shmobile/include/mach/gpio.h |    2 --
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 924f685..b9cfa99 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1509,7 +1509,7 @@ config LOCAL_TIMERS
 
 config ARCH_NR_GPIO
 	int
-	default 1024 if ARCH_TEGRA
+	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
index 7bf0890..de795b4 100644
--- a/arch/arm/mach-shmobile/include/mach/gpio.h
+++ b/arch/arm/mach-shmobile/include/mach/gpio.h
@@ -12,8 +12,6 @@
 
 #include <linux/kernel.h>
 #include <linux/errno.h>
-
-#define ARCH_NR_GPIOS 1024
 #include <linux/sh_pfc.h>
 
 #ifdef CONFIG_GPIOLIB
-- 
1.7.7.rc0.72.g4b5ea.dirty

