From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 28 Mar 2008 06:03:39 +0000
Subject: [PATCH] sh: Fix up uImage compression type
Message-Id: <47EC8A3B.9060406@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix up uImage compression type.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/boot/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boot/Makefile b/arch/sh/boot/Makefile
index 59f552c..ab4dc91 100644
--- a/arch/sh/boot/Makefile
+++ b/arch/sh/boot/Makefile
@@ -44,7 +44,7 @@ KERNEL_ENTRY	:= $(shell /bin/bash -c 'printf "0x%8x" \

 quiet_cmd_uimage = UIMAGE  $@
       cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A sh -O linux -T kernel \
-		   -C none -a $(KERNEL_LOAD) -e $(KERNEL_ENTRY) \
+		   -C gzip -a $(KERNEL_LOAD) -e $(KERNEL_ENTRY) \
 		   -n 'Linux-$(KERNELRELEASE)' -d $< $@

 $(obj)/uImage: $(obj)/vmlinux.bin.gz FORCE
