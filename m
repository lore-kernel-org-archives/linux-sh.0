From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 Jun 2013 05:55:58 +0000
Subject: [PATCH] ARM: zImage/virt: remove hyp-stub.S during distclean
Message-Id: <20130610060325.2335.65815.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Make sure hyp-stub.S gets removed during make distclean,
this left over file was introduced in commit:

424e599 ARM: zImage/virt: hyp mode entry support for the zImage loader

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/compressed/Makefile |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/compressed/Makefile
+++ work/arch/arm/boot/compressed/Makefile	2013-06-05 17:21:20.000000000 +0900
@@ -116,7 +116,8 @@ targets       := vmlinux vmlinux.lds \
 
 # Make sure files are removed during clean
 extra-y       += piggy.gzip piggy.lzo piggy.lzma piggy.xzkern \
-		 lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs)
+		 lib1funcs.S ashldi3.S $(libfdt) $(libfdt_hdrs) \
+		 hyp-stub.S
 
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 ORIG_CFLAGS := $(KBUILD_CFLAGS)
