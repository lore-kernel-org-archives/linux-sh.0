From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 04 Oct 2017 09:33:55 +0000
Subject: [PATCH] sh: remove pointless select of KBUILD_DEFCONFIG
Message-Id: <1507109635-28977-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org

KBUILD_DEFCONFIG := shx3_defconfig

is never used in a sensible way.  KBUILD_DEFCONFIG specifies the
defconfig file used by "make defconfig", but CONFIG_SUPERH32 is
never set when building config targets.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/sh/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 280bbff..c937ec0 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -96,6 +96,7 @@ defaultimage-$(CONFIG_SH_7619_SOLUTION_ENGINE)	:= vmlinux
 # Set some sensible Kbuild defaults
 boot := arch/sh/boot
 KBUILD_IMAGE		:= $(boot)/$(defaultimage-y)
+KBUILD_DEFCONFIG	:= cayman_defconfig
 
 #
 # Choosing incompatible machines durings configuration will result in
@@ -105,14 +106,12 @@ ifdef CONFIG_SUPERH32
 UTS_MACHINE		:= sh
 BITS			:= 32
 LDFLAGS_vmlinux		+= -e _stext
-KBUILD_DEFCONFIG	:= shx3_defconfig
 else
 UTS_MACHINE		:= sh64
 BITS			:= 64
 LDFLAGS_vmlinux		+= --defsym phys_stext=_stext-$(CONFIG_PAGE_OFFSET) \
 			   --defsym phys_stext_shmedia=phys_stext+1 \
 			   -e phys_stext_shmedia
-KBUILD_DEFCONFIG	:= cayman_defconfig
 endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-- 
2.7.4

