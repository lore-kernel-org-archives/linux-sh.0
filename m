From: Andrew Stubbs <ams@codesourcery.com>
Date: Fri, 26 Mar 2010 09:55:38 +0000
Subject: [PATCH 2.6.34-rc2] sh: Fix FDPIC binary loader
Message-Id: <4BAC849A.9090403@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Ensure that the aux table is properly initialized, even when optional 
features are missing. Without this, the FDPIC loader did not work.

Signed-off-by: Andrew Stubbs <ams@codesourcery.com>
---


diff --git a/arch/sh/include/asm/elf.h b/arch/sh/include/asm/elf.h
index ac04255..b2fefb3 100644
--- a/arch/sh/include/asm/elf.h
+++ b/arch/sh/include/asm/elf.h
@@ -211,15 +211,17 @@ extern void __kernel_vsyscall;

  #define VSYSCALL_AUX_ENT                                       \
         if (vdso_enabled)                                       \
-               NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_BASE);
+               NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_BASE);        \
+       else                                                    \
+               NEW_AUX_ENT(AT_IGNORE, 0); /* Match AT_VECTOR_SIZE_ARCH.  */
  #else
-#define VSYSCALL_AUX_ENT
+#define VSYSCALL_AUX_ENT NEW_AUX_ENT(AT_IGNORE, 0);
  #endif /* CONFIG_VSYSCALL */

  #ifdef CONFIG_SH_FPU
  #define FPU_AUX_ENT    NEW_AUX_ENT(AT_FPUCW, FPSCR_INIT)
  #else
-#define FPU_AUX_ENT
+#define FPU_AUX_ENT    NEW_AUX_ENT(AT_IGNORE, 0);
  #endif

  extern int l1i_cache_shape, l1d_cache_shape, l2_cache_shape;
