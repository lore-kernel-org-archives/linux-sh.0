From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Apr 2010 05:46:11 +0000
Subject: [PATCH] sh: add CONFIG_VIRTUALIZATION for virtio support
Message-Id: <20100428054611.5220.52869.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add CONFIG_VIRTUALIZATION to the SH architecture
and include the virtio code there. Used to enable
the virtio drivers under QEMU.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/Kconfig |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2010-04-28 14:36:28.000000000 +0900
@@ -871,4 +871,20 @@ source "security/Kconfig"
 
 source "crypto/Kconfig"
 
+menuconfig VIRTUALIZATION
+	bool "Virtualization"
+	default n
+	---help---
+	  Say Y here to get to see options for using your Linux host to run other
+	  operating systems inside virtual machines (guests).
+	  This option alone does not add any kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if VIRTUALIZATION
+
+source drivers/virtio/Kconfig
+
+endif # VIRTUALIZATION
+
 source "lib/Kconfig"
