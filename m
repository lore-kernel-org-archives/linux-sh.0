From: yoshii.takashi@renesas.com
Date: Mon, 30 Nov 2009 08:02:54 +0000
Subject: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

You can set boot parameters by config, ignoring data at the top of empty_zero_page.
This and CONFIG_CMDLINE make zImage to be simple "load and go" capable binary,
same as vmlinux (which has default boot parameters inside of it).

Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
---

I think people who already have "Linux aware" boot loader don't find anything interesting,
but this was helpful when I was debugging with a monitor with serial file transfer only.
IMHO, it might be a good to forget about parameters on the top of empty_zero_page.

/yoshii

---
 arch/sh/Kconfig             |   35 +++++++++++++++++++++++++++++++++++
 arch/sh/include/asm/setup.h |   13 +++++++++++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 0031a69..4800a6f 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -798,6 +798,41 @@ config CMDLINE
 	depends on CMDLINE_OVERWRITE || CMDLINE_EXTEND
 	default "console=ttySC1,115200"
 
+config PARAM_BOOL
+	bool "Default kernel params"
+	help
+	  Setting this option allows the boot parameters to be set.
+
+config PARAM_MOUNT_ROOT_RDONLY
+	int "MOUNT_ROOT_RDONLY"
+	depends on PARAM_BOOL
+	default 1
+
+config PARAM_RAMDISK_FLAGS
+	hex "RAMDISK_FLAGS"
+	depends on PARAM_BOOL
+	default 0
+
+config PARAM_ORIG_ROOT_DEV
+	hex "ORIG_ROOT_DEV"
+	depends on PARAM_BOOL
+	default 0x200
+
+config PARAM_LOADER_TYPE
+	hex "LOADER_TYPE"
+	depends on PARAM_BOOL
+	default 1
+
+config PARAM_INITRD_START
+	hex "INITRD_START"
+	depends on PARAM_BOOL
+	default 0
+
+config PARAM_INITRD_SIZE
+	hex "INITRD_SIZE"
+	depends on PARAM_BOOL
+	default 0
+
 endmenu
 
 menu "Bus options"
diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index ce37435..715cd6f 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -4,17 +4,26 @@
 #include <asm-generic/setup.h>
 
 #ifdef __KERNEL__
+#define PARAM	((unsigned char *)empty_zero_page)
+
+#if defined(CONFIG_PARAM_BOOL)
+#define MOUNT_ROOT_RDONLY (unsigned long)CONFIG_PARAM_MOUNT_ROOT_RDONLY
+#define RAMDISK_FLAGS (unsigned long)CONFIG_PARAM_RAMDISK_FLAGS
+#define ORIG_ROOT_DEV (unsigned long)CONFIG_PARAM_ORIG_ROOT_DEV
+#define LOADER_TYPE (unsigned long)CONFIG_PARAM_LOADER_TYPE
+#define INITRD_START (unsigned long)CONFIG_PARAM_INITRD_START
+#define INITRD_SIZE (unsigned long)CONFIG_PARAM_INITRD_SIZE
+#else
 /*
  * This is set up by the setup-routine at boot-time
  */
-#define PARAM	((unsigned char *)empty_zero_page)
-
 #define MOUNT_ROOT_RDONLY (*(unsigned long *) (PARAM+0x000))
 #define RAMDISK_FLAGS (*(unsigned long *) (PARAM+0x004))
 #define ORIG_ROOT_DEV (*(unsigned long *) (PARAM+0x008))
 #define LOADER_TYPE (*(unsigned long *) (PARAM+0x00c))
 #define INITRD_START (*(unsigned long *) (PARAM+0x010))
 #define INITRD_SIZE (*(unsigned long *) (PARAM+0x014))
+#endif
 /* ... */
 #define COMMAND_LINE ((char *) (PARAM+0x100))
 
-- 
1.6.4.4

