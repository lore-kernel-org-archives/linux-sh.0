From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Mon, 30 Oct 2017 11:27:20 +0000
Subject: [PATCH] sh: defconfig: Remove NUMA support from Migo-R
Message-Id: <1509362840-6317-1-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Building with CONFIG_NUMA=y prevents Migo-R from booting.
The system hangs just after kernel is decompressed.

   Image Name:   Linux-4.14.0-rc5-dirty
   Image Type:   SuperH Linux Kernel Image (gzip compressed)
   Data Size:    2591143 Bytes =  2.5 MB
   Load Address: 8c001000
   Entry Point:  8c002000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/configs/migor_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index e04f21b..7510de5 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -12,7 +12,6 @@ CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7722=y
 CONFIG_MEMORY_START=0x0c000000
-CONFIG_NUMA=y
 # CONFIG_MIGRATION is not set
 CONFIG_SH_MIGOR=y
 # CONFIG_SH_TIMER_CMT is not set
--
2.7.4

