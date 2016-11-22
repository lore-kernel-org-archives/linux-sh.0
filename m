From: Michal Marek <mmarek@suse.com>
Date: Tue, 22 Nov 2016 21:34:32 +0000
Subject: [PATCH 4/6] sh: Use full path in KBUILD_IMAGE definition
Message-Id: <20161122213434.14788-4-mmarek@suse.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20161122213434.14788-1-mmarek@suse.com>
In-Reply-To: <20161122213434.14788-1-mmarek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

The KBUILD_IMAGE variable is used by the rpm and deb-pkg targets, which
expect it to point to the image file in the build directory. The
builddeb script has a workaround for architectures which only provide
the basename, but let's provide a clean interface for packaging tools.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Michal Marek <mmarek@suse.com>
---
 arch/sh/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 336f33a419d9..280bbff12102 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -94,7 +94,8 @@ defaultimage-$(CONFIG_SH_7206_SOLUTION_ENGINE)	:= vmlinux
 defaultimage-$(CONFIG_SH_7619_SOLUTION_ENGINE)	:= vmlinux
 
 # Set some sensible Kbuild defaults
-KBUILD_IMAGE		:= $(defaultimage-y)
+boot := arch/sh/boot
+KBUILD_IMAGE		:= $(boot)/$(defaultimage-y)
 
 #
 # Choosing incompatible machines durings configuration will result in
@@ -186,8 +187,6 @@ cpuincdir-y			+= cpu-common	# Must be last
 drivers-y			+= arch/sh/drivers/
 drivers-$(CONFIG_OPROFILE)	+= arch/sh/oprofile/
 
-boot := arch/sh/boot
-
 cflags-y	+= $(foreach d, $(cpuincdir-y), -Iarch/sh/include/$(d)) \
 		   $(foreach d, $(machdir-y), -Iarch/sh/include/$(d))
 
@@ -211,7 +210,7 @@ BOOT_TARGETS = uImage uImage.bz2 uImage.gz uImage.lzma uImage.xz uImage.lzo \
 	       romImage
 PHONY += $(BOOT_TARGETS)
 
-all: $(KBUILD_IMAGE)
+all: $(notdir $(KBUILD_IMAGE))
 
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-- 
2.10.0

