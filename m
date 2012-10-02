From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 02 Oct 2012 16:36:40 +0000
Subject: [PATCH 01/17] ARM: shmobile: fix memory size for kota2_defconfig
Message-Id: <1349195816-2225-2-git-send-email-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1349195816-2225-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1349195816-2225-1-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@infradead.org
Cc: arm@kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>

The CONFIG_MEMORY_SIZE value is interpreted as a 32 bit integer, which
makes sense on a system without PAE. I'm assuming 0x10000000 (256 MB)
is the correct size, because that is used on most other shmobile
boards.

Without this patch, building kota2_defconfig results in:

/home/arnd/linux-arm/arch/arm/kernel/setup.c:790:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>
---
 arch/arm/configs/kota2_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/kota2_defconfig b/arch/arm/configs/kota2_defconfig
index b7735d6..0ea4c90 100644
--- a/arch/arm/configs/kota2_defconfig
+++ b/arch/arm/configs/kota2_defconfig
@@ -21,7 +21,7 @@ CONFIG_ARCH_SHMOBILE=y
 CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KOTA2=y
-CONFIG_MEMORY_SIZE=0x1e0000000
+CONFIG_MEMORY_SIZE=0x10000000
 # CONFIG_SH_TIMER_TMU is not set
 # CONFIG_SWP_EMULATE is not set
 CONFIG_CPU_BPREDICT_DISABLE=y
-- 
1.7.10

