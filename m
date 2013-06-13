From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Jun 2013 13:10:50 +0000
Subject: [PATCH 1/3] h8300/boot: Use POSIX "$((..))" instead of bashism "$[...]"
Message-Id: <1371129052-31506-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1371129052-31506-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1371129052-31506-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Ubuntu, where /bin/sh -> dash, "make ARCH=h8300 clean" gives:

printf: 1: $[0x00400000+0x00140000]: expected numeric value

Replace the bash-specific "$[...]" by POSIX "$((..))" for arithmetic
expansion to fix this.
Note that according to the bash 4.1 manpage, "$[...]" is deprecated, and
will be removed in upcoming versions of bash.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/h8300/boot/compressed/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/h8300/boot/compressed/Makefile b/arch/h8300/boot/compressed/Makefile
index 94faad1..787fd04 100644
--- a/arch/h8300/boot/compressed/Makefile
+++ b/arch/h8300/boot/compressed/Makefile
@@ -16,7 +16,7 @@ OBJECTS = $(obj)/head.o $(obj)/misc.o
 #
 CONFIG_MEMORY_START     ?= 0x00400000
 CONFIG_BOOT_LINK_OFFSET ?= 0x00140000
-IMAGE_OFFSET := $(shell printf "0x%08x" $$[$(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET)])
+IMAGE_OFFSET := $(shell printf "0x%08x" $$(($(CONFIG_MEMORY_START)+$(CONFIG_BOOT_LINK_OFFSET))))
 
 LDFLAGS_vmlinux := -Ttext $(IMAGE_OFFSET) -estartup $(obj)/vmlinux.lds
 
-- 
1.7.0.4

