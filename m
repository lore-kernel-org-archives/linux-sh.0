From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 02 Apr 2014 09:06:24 +0000
Subject: [PATCH] ARM: shmobile: Enable HIGHMEM in shmobile_defconfig
Message-Id: <20140402090624.22077.58451.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Many mach-shmobile hardware platforms include support for more
than 1GiB of RAM. Enable HIGHMEM by default to allow use of
larger amounts of memory.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-devel-v3.14-20140402

 arch/arm/configs/shmobile_defconfig |    1 +
 1 file changed, 1 insertion(+)


--- 0001/arch/arm/configs/shmobile_defconfig
+++ work/arch/arm/configs/shmobile_defconfig	2014-04-02 18:01:31.000000000 +0900
@@ -25,6 +25,7 @@ CONFIG_SCHED_MC=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_NR_CPUS=8
 CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
