From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 26 Sep 2018 01:27:08 +0000
Subject: [PATCH v2 resend 03/13] sh: include: convert to SPDX identifiers
Message-Id: <87lg7pys0q.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pnx1ys2k.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pnx1ys2k.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/include/asm/Kbuild                           |  1 +
 arch/sh/include/asm/addrspace.h                      |  5 +----
 arch/sh/include/asm/asm-offsets.h                    |  1 +
 arch/sh/include/asm/bl_bit_64.h                      |  7 ++-----
 arch/sh/include/asm/cache_insns_64.h                 |  7 ++-----
 arch/sh/include/asm/checksum_32.h                    |  5 +----
 arch/sh/include/asm/cmpxchg-xchg.h                   |  4 +---
 arch/sh/include/asm/device.h                         |  5 ++---
 arch/sh/include/asm/dma-register.h                   |  7 ++-----
 arch/sh/include/asm/dma.h                            |  7 ++-----
 arch/sh/include/asm/dwarf.h                          |  8 ++------
 arch/sh/include/asm/fb.h                             |  1 +
 arch/sh/include/asm/fixmap.h                         |  7 ++-----
 arch/sh/include/asm/flat.h                           |  7 ++-----
 arch/sh/include/asm/freq.h                           |  8 ++------
 arch/sh/include/asm/gpio.h                           |  7 ++-----
 arch/sh/include/asm/machvec.h                        |  6 ++----
 arch/sh/include/asm/mmu_context_64.h                 |  5 +----
 arch/sh/include/asm/pgtable.h                        |  7 ++-----
 arch/sh/include/asm/pgtable_64.h                     |  5 +----
 arch/sh/include/asm/processor_64.h                   |  5 +----
 arch/sh/include/asm/sfp-machine.h                    | 20 ++++----------------
 arch/sh/include/asm/shmparam.h                       |  7 ++-----
 arch/sh/include/asm/siu.h                            |  7 ++-----
 arch/sh/include/asm/spinlock-cas.h                   |  7 ++-----
 arch/sh/include/asm/spinlock-llsc.h                  |  7 ++-----
 arch/sh/include/asm/spinlock.h                       |  7 ++-----
 arch/sh/include/asm/string_32.h                      |  1 +
 arch/sh/include/asm/switch_to.h                      |  7 ++-----
 arch/sh/include/asm/switch_to_64.h                   |  7 ++-----
 arch/sh/include/asm/tlb_64.h                         |  7 ++-----
 arch/sh/include/asm/traps_64.h                       |  7 ++-----
 arch/sh/include/asm/uaccess_64.h                     |  5 +----
 arch/sh/include/asm/vga.h                            |  1 +
 arch/sh/include/asm/watchdog.h                       |  8 ++------
 arch/sh/include/cpu-common/cpu/addrspace.h           |  7 ++-----
 arch/sh/include/cpu-common/cpu/mmu_context.h         |  7 ++-----
 arch/sh/include/cpu-common/cpu/pfc.h                 | 12 ++----------
 arch/sh/include/cpu-common/cpu/timer.h               |  1 +
 arch/sh/include/cpu-sh2/cpu/cache.h                  |  7 ++-----
 arch/sh/include/cpu-sh2/cpu/freq.h                   |  7 ++-----
 arch/sh/include/cpu-sh2/cpu/watchdog.h               |  7 ++-----
 arch/sh/include/cpu-sh2a/cpu/cache.h                 |  7 ++-----
 arch/sh/include/cpu-sh2a/cpu/freq.h                  |  7 ++-----
 arch/sh/include/cpu-sh2a/cpu/watchdog.h              |  1 +
 arch/sh/include/cpu-sh3/cpu/cache.h                  |  7 ++-----
 arch/sh/include/cpu-sh3/cpu/dma-register.h           |  7 ++-----
 arch/sh/include/cpu-sh3/cpu/freq.h                   |  7 ++-----
 arch/sh/include/cpu-sh3/cpu/gpio.h                   |  7 ++-----
 arch/sh/include/cpu-sh3/cpu/mmu_context.h            |  7 ++-----
 arch/sh/include/cpu-sh3/cpu/watchdog.h               |  7 ++-----
 arch/sh/include/cpu-sh4/cpu/addrspace.h              |  5 +----
 arch/sh/include/cpu-sh4/cpu/cache.h                  |  7 ++-----
 arch/sh/include/cpu-sh4/cpu/dma-register.h           |  7 ++-----
 arch/sh/include/cpu-sh4/cpu/fpu.h                    |  6 ++----
 arch/sh/include/cpu-sh4/cpu/freq.h                   |  7 ++-----
 arch/sh/include/cpu-sh4/cpu/mmu_context.h            |  7 ++-----
 arch/sh/include/cpu-sh4/cpu/sh7786.h                 |  7 ++-----
 arch/sh/include/cpu-sh4/cpu/sq.h                     |  7 ++-----
 arch/sh/include/cpu-sh4/cpu/watchdog.h               |  7 ++-----
 arch/sh/include/cpu-sh5/cpu/cache.h                  |  5 +----
 arch/sh/include/cpu-sh5/cpu/irq.h                    |  5 +----
 arch/sh/include/cpu-sh5/cpu/registers.h              |  5 +----
 arch/sh/include/mach-common/mach/hp6xx.h             | 12 ++++--------
 arch/sh/include/mach-common/mach/lboxre2.h           |  6 +-----
 arch/sh/include/mach-common/mach/magicpanelr2.h      |  7 ++-----
 arch/sh/include/mach-common/mach/mangle-port.h       |  7 ++-----
 arch/sh/include/mach-common/mach/microdev.h          |  6 ++----
 arch/sh/include/mach-common/mach/sdk7780.h           |  5 +----
 arch/sh/include/mach-common/mach/secureedge5410.h    |  6 ++----
 arch/sh/include/mach-common/mach/sh7763rdp.h         |  6 +-----
 arch/sh/include/mach-dreamcast/mach/dma.h            |  7 ++-----
 arch/sh/include/mach-dreamcast/mach/pci.h            |  7 ++-----
 arch/sh/include/mach-dreamcast/mach/sysasic.h        |  7 +++----
 .../include/mach-ecovec24/mach/partner-jet-setup.txt |  1 +
 .../include/mach-kfr2r09/mach/partner-jet-setup.txt  |  1 +
 arch/sh/include/mach-se/mach/se7721.h                |  8 ++------
 arch/sh/include/mach-se/mach/se7722.h                |  6 +-----
 arch/sh/include/mach-se/mach/se7724.h                |  6 +-----
 arch/sh/include/mach-se/mach/se7780.h                |  5 +----
 arch/sh/include/uapi/asm/Kbuild                      |  1 +
 arch/sh/include/uapi/asm/setup.h                     |  1 +
 arch/sh/include/uapi/asm/types.h                     |  1 +
 83 files changed, 142 insertions(+), 357 deletions(-)

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 6a5609a..f444077 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 3d1ae2b..34bfbcd 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -1,7 +1,4 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+/* SPDX-License-Identifier: GPL-2.0
  *
  * Copyright (C) 1999 by Kaz Kojima
  *
diff --git a/arch/sh/include/asm/asm-offsets.h b/arch/sh/include/asm/asm-offsets.h
index d370ee3..9f85357 100644
--- a/arch/sh/include/asm/asm-offsets.h
+++ b/arch/sh/include/asm/asm-offsets.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #include <generated/asm-offsets.h>
diff --git a/arch/sh/include/asm/bl_bit_64.h b/arch/sh/include/asm/bl_bit_64.h
index 6cc8711..aac9780 100644
--- a/arch/sh/include/asm/bl_bit_64.h
+++ b/arch/sh/include/asm/bl_bit_64.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_BL_BIT_64_H
 #define __ASM_SH_BL_BIT_64_H
diff --git a/arch/sh/include/asm/cache_insns_64.h b/arch/sh/include/asm/cache_insns_64.h
index 70b6357..ed682b9 100644
--- a/arch/sh/include/asm/cache_insns_64.h
+++ b/arch/sh/include/asm/cache_insns_64.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_CACHE_INSNS_64_H
 #define __ASM_SH_CACHE_INSNS_64_H
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 9c84386..b58f3d9 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_CHECKSUM_H
 #define __ASM_SH_CHECKSUM_H
 
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 1999 by Kaz Kojima & Niibe Yutaka
  */
 
diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/arch/sh/include/asm/cmpxchg-xchg.h
index 593a970..c373f21 100644
--- a/arch/sh/include/asm/cmpxchg-xchg.h
+++ b/arch/sh/include/asm/cmpxchg-xchg.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_CMPXCHG_XCHG_H
 #define __ASM_SH_CMPXCHG_XCHG_H
 
 /*
  * Copyright (C) 2016 Red Hat, Inc.
  * Author: Michael S. Tsirkin <mst@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See the
- * file "COPYING" in the main directory of this archive for more details.
  */
 #include <linux/bits.h>
 #include <linux/compiler.h>
diff --git a/arch/sh/include/asm/device.h b/arch/sh/include/asm/device.h
index 071bcb4..6f3e686 100644
--- a/arch/sh/include/asm/device.h
+++ b/arch/sh/include/asm/device.h
@@ -1,7 +1,6 @@
-/*
- * Arch specific extensions to struct device
+/* SPDX-License-Identifier: GPL-2.0
  *
- * This file is released under the GPLv2
+ * Arch specific extensions to struct device
  */
 #ifndef __ASM_SH_DEVICE_H
 #define __ASM_SH_DEVICE_H
diff --git a/arch/sh/include/asm/dma-register.h b/arch/sh/include/asm/dma-register.h
index c757b47..724dab91 100644
--- a/arch/sh/include/asm/dma-register.h
+++ b/arch/sh/include/asm/dma-register.h
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Common header for the legacy SH DMA driver and the new dmaengine driver
  *
  * extracted from arch/sh/include/asm/dma-sh.h:
  *
  * Copyright (C) 2000  Takashi YOSHII
  * Copyright (C) 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef DMA_REGISTER_H
 #define DMA_REGISTER_H
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index fb6e4f7..4d5a21a 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/dma.h
  *
  * Copyright (C) 2003, 2004  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_DMA_H
 #define __ASM_SH_DMA_H
diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
index d62abd1..5719544 100644
--- a/arch/sh/include/asm/dwarf.h
+++ b/arch/sh/include/asm/dwarf.h
@@ -1,10 +1,6 @@
-/*
- * Copyright (C) 2009 Matt Fleming <matt@console-pimps.org>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+/* SPDX-License-Identifier: GPL-2.0
  *
+ * Copyright (C) 2009 Matt Fleming <matt@console-pimps.org>
  */
 #ifndef __ASM_SH_DWARF_H
 #define __ASM_SH_DWARF_H
diff --git a/arch/sh/include/asm/fb.h b/arch/sh/include/asm/fb.h
index d92e99c..9a0bca2 100644
--- a/arch/sh/include/asm/fb.h
+++ b/arch/sh/include/asm/fb.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index 4daf91c..e30348c 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -1,9 +1,6 @@
-/*
- * fixmap.h: compile-time virtual memory allocation
+/* SPDX-License-Identifier: GPL-2.0
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ * fixmap.h: compile-time virtual memory allocation
  *
  * Copyright (C) 1998 Ingo Molnar
  *
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 275fcae..843d458 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/flat.h
  *
  * uClinux flat-format executables
  *
  * Copyright (C) 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive for
- * more details.
  */
 #ifndef __ASM_SH_FLAT_H
 #define __ASM_SH_FLAT_H
diff --git a/arch/sh/include/asm/freq.h b/arch/sh/include/asm/freq.h
index 4ece90b..18133bf 100644
--- a/arch/sh/include/asm/freq.h
+++ b/arch/sh/include/asm/freq.h
@@ -1,12 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * include/asm-sh/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
  */
 #ifndef __ASM_SH_FREQ_H
 #define __ASM_SH_FREQ_H
diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
index 7dfe15e..35191889 100644
--- a/arch/sh/include/asm/gpio.h
+++ b/arch/sh/include/asm/gpio.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *  include/asm-sh/gpio.h
  *
  * Generic GPIO API and pinmux table support for SuperH.
  *
  * Copyright (c) 2008 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_GPIO_H
 #define __ASM_SH_GPIO_H
diff --git a/arch/sh/include/asm/machvec.h b/arch/sh/include/asm/machvec.h
index d3324e4..f7d0554 100644
--- a/arch/sh/include/asm/machvec.h
+++ b/arch/sh/include/asm/machvec.h
@@ -1,10 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/machvec.h
  *
  * Copyright 2000 Stuart Menefy (stuart.menefy@st.com)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 
 #ifndef _ASM_SH_MACHVEC_H
diff --git a/arch/sh/include/asm/mmu_context_64.h b/arch/sh/include/asm/mmu_context_64.h
index de12102..bacafe0 100644
--- a/arch/sh/include/asm/mmu_context_64.h
+++ b/arch/sh/include/asm/mmu_context_64.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_MMU_CONTEXT_64_H
 #define __ASM_SH_MMU_CONTEXT_64_H
 
@@ -6,10 +7,6 @@
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <cpu/registers.h>
 #include <asm/cacheflush.h>
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index f6abfe2..3587103 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * This file contains the functions and defines necessary to modify and
  * use the SuperH page table tree.
  *
  * Copyright (C) 1999 Niibe Yutaka
  * Copyright (C) 2002 - 2007 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file "COPYING" in the main directory of this
- * archive for more details.
  */
 #ifndef __ASM_SH_PGTABLE_H
 #define __ASM_SH_PGTABLE_H
diff --git a/arch/sh/include/asm/pgtable_64.h b/arch/sh/include/asm/pgtable_64.h
index 0742496..1778bc5 100644
--- a/arch/sh/include/asm/pgtable_64.h
+++ b/arch/sh/include/asm/pgtable_64.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_PGTABLE_64_H
 #define __ASM_SH_PGTABLE_64_H
 
@@ -10,10 +11,6 @@
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003, 2004  Paul Mundt
  * Copyright (C) 2003, 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/threads.h>
 #include <asm/processor.h>
diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
index 777a163..245ba8a 100644
--- a/arch/sh/include/asm/processor_64.h
+++ b/arch/sh/include/asm/processor_64.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_PROCESSOR_64_H
 #define __ASM_SH_PROCESSOR_64_H
 
@@ -7,10 +8,6 @@
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASSEMBLY__
 
diff --git a/arch/sh/include/asm/sfp-machine.h b/arch/sh/include/asm/sfp-machine.h
index d3c5484..cbc7cf8c 100644
--- a/arch/sh/include/asm/sfp-machine.h
+++ b/arch/sh/include/asm/sfp-machine.h
@@ -1,4 +1,6 @@
-/* Machine-dependent software floating-point definitions.
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Machine-dependent software floating-point definitions.
    SuperH kernel version.
    Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
@@ -6,21 +8,7 @@
 		  Jakub Jelinek (jj@ultra.linux.cz),
 		  David S. Miller (davem@redhat.com) and
 		  Peter Maydell (pmaydell@chiark.greenend.org.uk).
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
-
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If
-   not, write to the Free Software Foundation, Inc.,
-   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */
+*/
 
 #ifndef _SFP_MACHINE_H
 #define _SFP_MACHINE_H
diff --git a/arch/sh/include/asm/shmparam.h b/arch/sh/include/asm/shmparam.h
index ba1758d..6c580a6 100644
--- a/arch/sh/include/asm/shmparam.h
+++ b/arch/sh/include/asm/shmparam.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/shmparam.h
  *
  * Copyright (C) 1999 Niibe Yutaka
  * Copyright (C) 2006 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_SHMPARAM_H
 #define __ASM_SH_SHMPARAM_H
diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
index 580b7ac..35e4839 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * platform header for the SIU ASoC driver
  *
  * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef ASM_SIU_H
diff --git a/arch/sh/include/asm/spinlock-cas.h b/arch/sh/include/asm/spinlock-cas.h
index 270ee4d..3d49985 100644
--- a/arch/sh/include/asm/spinlock-cas.h
+++ b/arch/sh/include/asm/spinlock-cas.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/spinlock-cas.h
  *
  * Copyright (C) 2015 SEI
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_SPINLOCK_CAS_H
 #define __ASM_SH_SPINLOCK_CAS_H
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index 715595d..786ee0f 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/spinlock-llsc.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
  * Copyright (C) 2006, 2007 Akio Idehara
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_SPINLOCK_LLSC_H
 #define __ASM_SH_SPINLOCK_LLSC_H
diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
index c2c61ea..fa6801f 100644
--- a/arch/sh/include/asm/spinlock.h
+++ b/arch/sh/include/asm/spinlock.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/spinlock.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
  * Copyright (C) 2006, 2007 Akio Idehara
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_SPINLOCK_H
 #define __ASM_SH_SPINLOCK_H
diff --git a/arch/sh/include/asm/string_32.h b/arch/sh/include/asm/string_32.h
index 55f8db6..3558b1d 100644
--- a/arch/sh/include/asm/string_32.h
+++ b/arch/sh/include/asm/string_32.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_STRING_H
 #define __ASM_SH_STRING_H
 
diff --git a/arch/sh/include/asm/switch_to.h b/arch/sh/include/asm/switch_to.h
index bcd722f..9eec80a 100644
--- a/arch/sh/include/asm/switch_to.h
+++ b/arch/sh/include/asm/switch_to.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_SWITCH_TO_H
 #define __ASM_SH_SWITCH_TO_H
diff --git a/arch/sh/include/asm/switch_to_64.h b/arch/sh/include/asm/switch_to_64.h
index ba3129d..2dbf231 100644
--- a/arch/sh/include/asm/switch_to_64.h
+++ b/arch/sh/include/asm/switch_to_64.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_SWITCH_TO_64_H
 #define __ASM_SH_SWITCH_TO_64_H
diff --git a/arch/sh/include/asm/tlb_64.h b/arch/sh/include/asm/tlb_64.h
index ef0ae2a..59fa0a2 100644
--- a/arch/sh/include/asm/tlb_64.h
+++ b/arch/sh/include/asm/tlb_64.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/tlb_64.h
  *
  * Copyright (C) 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_TLB_64_H
 #define __ASM_SH_TLB_64_H
diff --git a/arch/sh/include/asm/traps_64.h b/arch/sh/include/asm/traps_64.h
index ef5eff91..f28db6d 100644
--- a/arch/sh/include/asm/traps_64.h
+++ b/arch/sh/include/asm/traps_64.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_TRAPS_64_H
 #define __ASM_SH_TRAPS_64_H
diff --git a/arch/sh/include/asm/uaccess_64.h b/arch/sh/include/asm/uaccess_64.h
index ca5073d..0c19d02 100644
--- a/arch/sh/include/asm/uaccess_64.h
+++ b/arch/sh/include/asm/uaccess_64.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_UACCESS_64_H
 #define __ASM_SH_UACCESS_64_H
 
@@ -15,10 +16,6 @@
  *     MIPS implementation version 1.15 by
  *              Copyright (C) 1996, 1997, 1998 by Ralf Baechle
  *     and i386 version.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #define __get_user_size(x,ptr,size,retval)			\
diff --git a/arch/sh/include/asm/vga.h b/arch/sh/include/asm/vga.h
index 06a5de8..089fbdc 100644
--- a/arch/sh/include/asm/vga.h
+++ b/arch/sh/include/asm/vga.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_VGA_H
 #define __ASM_SH_VGA_H
 
diff --git a/arch/sh/include/asm/watchdog.h b/arch/sh/include/asm/watchdog.h
index 85a7aca..cecd0fc 100644
--- a/arch/sh/include/asm/watchdog.h
+++ b/arch/sh/include/asm/watchdog.h
@@ -1,14 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0+
+ *
  * include/asm-sh/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
  * Copyright (C) 2009 Siemens AG
  * Copyright (C) 2009 Valentin Sitdikov
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
  */
 #ifndef __ASM_SH_WATCHDOG_H
 #define __ASM_SH_WATCHDOG_H
diff --git a/arch/sh/include/cpu-common/cpu/addrspace.h b/arch/sh/include/cpu-common/cpu/addrspace.h
index 2b9ab93..d8bf5d7 100644
--- a/arch/sh/include/cpu-common/cpu/addrspace.h
+++ b/arch/sh/include/cpu-common/cpu/addrspace.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Definitions for the address spaces of the SH-2 CPUs.
  *
  * Copyright (C) 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH2_ADDRSPACE_H
 #define __ASM_CPU_SH2_ADDRSPACE_H
diff --git a/arch/sh/include/cpu-common/cpu/mmu_context.h b/arch/sh/include/cpu-common/cpu/mmu_context.h
index beeb299..cef3a30 100644
--- a/arch/sh/include/cpu-common/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-common/cpu/mmu_context.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh2/mmu_context.h
  *
  * Copyright (C) 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH2_MMU_CONTEXT_H
 #define __ASM_CPU_SH2_MMU_CONTEXT_H
diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
index e538813..879d2c9 100644
--- a/arch/sh/include/cpu-common/cpu/pfc.h
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -1,16 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * SH Pin Function Control Initialization
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #ifndef __ARCH_SH_CPU_PFC_H__
diff --git a/arch/sh/include/cpu-common/cpu/timer.h b/arch/sh/include/cpu-common/cpu/timer.h
index a39c241..af51438 100644
--- a/arch/sh/include/cpu-common/cpu/timer.h
+++ b/arch/sh/include/cpu-common/cpu/timer.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_CPU_SH2_TIMER_H
 #define __ASM_CPU_SH2_TIMER_H
 
diff --git a/arch/sh/include/cpu-sh2/cpu/cache.h b/arch/sh/include/cpu-sh2/cpu/cache.h
index aa1b2b9..070aa9f 100644
--- a/arch/sh/include/cpu-sh2/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2/cpu/cache.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh2/cache.h
  *
  * Copyright (C) 2003 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH2_CACHE_H
 #define __ASM_CPU_SH2_CACHE_H
diff --git a/arch/sh/include/cpu-sh2/cpu/freq.h b/arch/sh/include/cpu-sh2/cpu/freq.h
index 31de475..fb2e5d2 100644
--- a/arch/sh/include/cpu-sh2/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2/cpu/freq.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh2/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH2_FREQ_H
 #define __ASM_CPU_SH2_FREQ_H
diff --git a/arch/sh/include/cpu-sh2/cpu/watchdog.h b/arch/sh/include/cpu-sh2/cpu/watchdog.h
index 1eab8aa..141fe29 100644
--- a/arch/sh/include/cpu-sh2/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh2/cpu/watchdog.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh2/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH2_WATCHDOG_H
 #define __ASM_CPU_SH2_WATCHDOG_H
diff --git a/arch/sh/include/cpu-sh2a/cpu/cache.h b/arch/sh/include/cpu-sh2a/cpu/cache.h
index b27ce92..06efb23 100644
--- a/arch/sh/include/cpu-sh2a/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2a/cpu/cache.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh2a/cache.h
  *
  * Copyright (C) 2004 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH2A_CACHE_H
 #define __ASM_CPU_SH2A_CACHE_H
diff --git a/arch/sh/include/cpu-sh2a/cpu/freq.h b/arch/sh/include/cpu-sh2a/cpu/freq.h
index 830fd43..fb0813f 100644
--- a/arch/sh/include/cpu-sh2a/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2a/cpu/freq.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh2a/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH2A_FREQ_H
 #define __ASM_CPU_SH2A_FREQ_H
diff --git a/arch/sh/include/cpu-sh2a/cpu/watchdog.h b/arch/sh/include/cpu-sh2a/cpu/watchdog.h
index e7e8259..8f932b7 100644
--- a/arch/sh/include/cpu-sh2a/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh2a/cpu/watchdog.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #include <cpu-sh2/cpu/watchdog.h>
diff --git a/arch/sh/include/cpu-sh3/cpu/cache.h b/arch/sh/include/cpu-sh3/cpu/cache.h
index 29700fd..f571248 100644
--- a/arch/sh/include/cpu-sh3/cpu/cache.h
+++ b/arch/sh/include/cpu-sh3/cpu/cache.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh3/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH3_CACHE_H
 #define __ASM_CPU_SH3_CACHE_H
diff --git a/arch/sh/include/cpu-sh3/cpu/dma-register.h b/arch/sh/include/cpu-sh3/cpu/dma-register.h
index 2349e48..c0f921f 100644
--- a/arch/sh/include/cpu-sh3/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh3/cpu/dma-register.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * SH3 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef CPU_DMA_REGISTER_H
 #define CPU_DMA_REGISTER_H
diff --git a/arch/sh/include/cpu-sh3/cpu/freq.h b/arch/sh/include/cpu-sh3/cpu/freq.h
index 53c6230..7290f02 100644
--- a/arch/sh/include/cpu-sh3/cpu/freq.h
+++ b/arch/sh/include/cpu-sh3/cpu/freq.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh3/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH3_FREQ_H
 #define __ASM_CPU_SH3_FREQ_H
diff --git a/arch/sh/include/cpu-sh3/cpu/gpio.h b/arch/sh/include/cpu-sh3/cpu/gpio.h
index 9a22b88..aeb0588 100644
--- a/arch/sh/include/cpu-sh3/cpu/gpio.h
+++ b/arch/sh/include/cpu-sh3/cpu/gpio.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *  include/asm-sh/cpu-sh3/gpio.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
  *
  *  Addresses for the Pin Function Controller
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef _CPU_SH3_GPIO_H
 #define _CPU_SH3_GPIO_H
diff --git a/arch/sh/include/cpu-sh3/cpu/mmu_context.h b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
index 0c7c735..ead9a6f 100644
--- a/arch/sh/include/cpu-sh3/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh3/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH3_MMU_CONTEXT_H
 #define __ASM_CPU_SH3_MMU_CONTEXT_H
diff --git a/arch/sh/include/cpu-sh3/cpu/watchdog.h b/arch/sh/include/cpu-sh3/cpu/watchdog.h
index 4ee0347..9d7e9d9 100644
--- a/arch/sh/include/cpu-sh3/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh3/cpu/watchdog.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh3/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH3_WATCHDOG_H
 #define __ASM_CPU_SH3_WATCHDOG_H
diff --git a/arch/sh/include/cpu-sh4/cpu/addrspace.h b/arch/sh/include/cpu-sh4/cpu/addrspace.h
index d51da25..f006c94 100644
--- a/arch/sh/include/cpu-sh4/cpu/addrspace.h
+++ b/arch/sh/include/cpu-sh4/cpu/addrspace.h
@@ -1,7 +1,4 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+/* SPDX-License-Identifier: GPL-2.0
  *
  * Copyright (C) 1999 by Kaz Kojima
  *
diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
index 92c4cd1..72b4d13 100644
--- a/arch/sh/include/cpu-sh4/cpu/cache.h
+++ b/arch/sh/include/cpu-sh4/cpu/cache.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh4/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH4_CACHE_H
 #define __ASM_CPU_SH4_CACHE_H
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 9cd81e5..53f7ab9 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * SH4 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #ifndef CPU_DMA_REGISTER_H
 #define CPU_DMA_REGISTER_H
diff --git a/arch/sh/include/cpu-sh4/cpu/fpu.h b/arch/sh/include/cpu-sh4/cpu/fpu.h
index febef73..29f451b 100644
--- a/arch/sh/include/cpu-sh4/cpu/fpu.h
+++ b/arch/sh/include/cpu-sh4/cpu/fpu.h
@@ -1,12 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * linux/arch/sh/kernel/cpu/sh4/sh4_fpu.h
  *
  * Copyright (C) 2006 STMicroelectronics Limited
  * Author: Carl Shaw <carl.shaw@st.com>
  *
- * May be copied or modified under the terms of the GNU General Public
- * License Version 2.  See linux/COPYING for more information.
- *
  * Definitions for SH4 FPU operations
  */
 
diff --git a/arch/sh/include/cpu-sh4/cpu/freq.h b/arch/sh/include/cpu-sh4/cpu/freq.h
index 1631fc2..662f0f3 100644
--- a/arch/sh/include/cpu-sh4/cpu/freq.h
+++ b/arch/sh/include/cpu-sh4/cpu/freq.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh4/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH4_FREQ_H
 #define __ASM_CPU_SH4_FREQ_H
diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index e46ec70..421b56d 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh4/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH4_MMU_CONTEXT_H
 #define __ASM_CPU_SH4_MMU_CONTEXT_H
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
index 96b8cb1..8f9bfbf 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * SH7786 Pinmux
  *
  * Copyright (C) 2008, 2009  Renesas Solutions Corp.
  * Kuninori Morimoto <morimoto.kuninori@renesas.com>
  *
  *  Based on sh7785.h
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef __CPU_SH7786_H__
diff --git a/arch/sh/include/cpu-sh4/cpu/sq.h b/arch/sh/include/cpu-sh4/cpu/sq.h
index 74716ba..81966e4 100644
--- a/arch/sh/include/cpu-sh4/cpu/sq.h
+++ b/arch/sh/include/cpu-sh4/cpu/sq.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh4/sq.h
  *
  * Copyright (C) 2001, 2002, 2003  Paul Mundt
  * Copyright (C) 2001, 2002  M. R. Brown
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH4_SQ_H
 #define __ASM_CPU_SH4_SQ_H
diff --git a/arch/sh/include/cpu-sh4/cpu/watchdog.h b/arch/sh/include/cpu-sh4/cpu/watchdog.h
index 7f62b93..fa7bcb3 100644
--- a/arch/sh/include/cpu-sh4/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh4/cpu/watchdog.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/cpu-sh4/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
  * Copyright (C) 2009 Siemens AG
  * Copyright (C) 2009 Sitdikov Valentin
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_CPU_SH4_WATCHDOG_H
 #define __ASM_CPU_SH4_WATCHDOG_H
diff --git a/arch/sh/include/cpu-sh5/cpu/cache.h b/arch/sh/include/cpu-sh5/cpu/cache.h
index ed050ab..ef49538 100644
--- a/arch/sh/include/cpu-sh5/cpu/cache.h
+++ b/arch/sh/include/cpu-sh5/cpu/cache.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_CPU_SH5_CACHE_H
 #define __ASM_SH_CPU_SH5_CACHE_H
 
@@ -6,10 +7,6 @@
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003, 2004  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #define L1_CACHE_SHIFT		5
diff --git a/arch/sh/include/cpu-sh5/cpu/irq.h b/arch/sh/include/cpu-sh5/cpu/irq.h
index 0ccf257..4aa6ac5 100644
--- a/arch/sh/include/cpu-sh5/cpu/irq.h
+++ b/arch/sh/include/cpu-sh5/cpu/irq.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_CPU_SH5_IRQ_H
 #define __ASM_SH_CPU_SH5_IRQ_H
 
@@ -5,10 +6,6 @@
  * include/asm-sh/cpu-sh5/irq.h
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 
diff --git a/arch/sh/include/cpu-sh5/cpu/registers.h b/arch/sh/include/cpu-sh5/cpu/registers.h
index 6664ea6..372c1e1 100644
--- a/arch/sh/include/cpu-sh5/cpu/registers.h
+++ b/arch/sh/include/cpu-sh5/cpu/registers.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_CPU_SH5_REGISTERS_H
 #define __ASM_SH_CPU_SH5_REGISTERS_H
 
@@ -6,10 +7,6 @@
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifdef __ASSEMBLY__
diff --git a/arch/sh/include/mach-common/mach/hp6xx.h b/arch/sh/include/mach-common/mach/hp6xx.h
index 6aaaf85..71241f0 100644
--- a/arch/sh/include/mach-common/mach/hp6xx.h
+++ b/arch/sh/include/mach-common/mach/hp6xx.h
@@ -1,14 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2003, 2004, 2005  Andriy Skulysh
+ */
 #ifndef __ASM_SH_HP6XX_H
 #define __ASM_SH_HP6XX_H
 
-/*
- * Copyright (C) 2003, 2004, 2005  Andriy Skulysh
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- */
 #include <linux/sh_intc.h>
 
 #define HP680_BTN_IRQ		evt2irq(0x600)	/* IRQ0_IRQ */
diff --git a/arch/sh/include/mach-common/mach/lboxre2.h b/arch/sh/include/mach-common/mach/lboxre2.h
index 3a4dcc5..5b6bb8e 100644
--- a/arch/sh/include/mach-common/mach/lboxre2.h
+++ b/arch/sh/include/mach-common/mach/lboxre2.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_LBOXRE2_H
 #define __ASM_SH_LBOXRE2_H
 
@@ -5,11 +6,6 @@
  * Copyright (C) 2007 Nobuhiro Iwamatsu
  *
  * NTT COMWARE L-BOX RE2 support
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/sh_intc.h>
 
diff --git a/arch/sh/include/mach-common/mach/magicpanelr2.h b/arch/sh/include/mach-common/mach/magicpanelr2.h
index eb0cf20..c2d218c 100644
--- a/arch/sh/include/mach-common/mach/magicpanelr2.h
+++ b/arch/sh/include/mach-common/mach/magicpanelr2.h
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *  include/asm-sh/magicpanelr2.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
  *
  *  I/O addresses and bitmasks for Magic Panel Release 2 board
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #ifndef __ASM_SH_MAGICPANELR2_H
diff --git a/arch/sh/include/mach-common/mach/mangle-port.h b/arch/sh/include/mach-common/mach/mangle-port.h
index 4ca1769..dd5a761 100644
--- a/arch/sh/include/mach-common/mach/mangle-port.h
+++ b/arch/sh/include/mach-common/mach/mangle-port.h
@@ -1,9 +1,6 @@
-/*
- * SH version cribbed from the MIPS copy:
+/* SPDX-License-Identifier: GPL-2.0
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+ * SH version cribbed from the MIPS copy:
  *
  * Copyright (C) 2003, 2004 Ralf Baechle
  */
diff --git a/arch/sh/include/mach-common/mach/microdev.h b/arch/sh/include/mach-common/mach/microdev.h
index dcb05fa..0e2f9ab 100644
--- a/arch/sh/include/mach-common/mach/microdev.h
+++ b/arch/sh/include/mach-common/mach/microdev.h
@@ -1,12 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * linux/include/asm-sh/microdev.h
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
  *
  * Definitions for the SuperH SH4-202 MicroDev board.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #ifndef __ASM_SH_MICRODEV_H
 #define __ASM_SH_MICRODEV_H
diff --git a/arch/sh/include/mach-common/mach/sdk7780.h b/arch/sh/include/mach-common/mach/sdk7780.h
index ce64e02..a27dbe4 100644
--- a/arch/sh/include/mach-common/mach/sdk7780.h
+++ b/arch/sh/include/mach-common/mach/sdk7780.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_RENESAS_SDK7780_H
 #define __ASM_SH_RENESAS_SDK7780_H
 
@@ -6,10 +7,6 @@
  *
  * Renesas Solutions SH7780 SDK Support
  * Copyright (C) 2008 Nicholas Beck <nbeck@mpc-data.co.uk>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sh_intc.h>
 #include <asm/addrspace.h>
diff --git a/arch/sh/include/mach-common/mach/secureedge5410.h b/arch/sh/include/mach-common/mach/secureedge5410.h
index 3653b9a4..dfc68aa 100644
--- a/arch/sh/include/mach-common/mach/secureedge5410.h
+++ b/arch/sh/include/mach-common/mach/secureedge5410.h
@@ -1,11 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/snapgear.h
  *
  * Modified version of io_se.h for the snapgear-specific functions.
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * IO functions for a SnapGear
  */
 
diff --git a/arch/sh/include/mach-common/mach/sh7763rdp.h b/arch/sh/include/mach-common/mach/sh7763rdp.h
index 8750cc8..301f85a 100644
--- a/arch/sh/include/mach-common/mach/sh7763rdp.h
+++ b/arch/sh/include/mach-common/mach/sh7763rdp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_SH7763RDP_H
 #define __ASM_SH_SH7763RDP_H
 
@@ -6,11 +7,6 @@
  *
  * Copyright (C) 2008 Renesas Solutions
  * Copyright (C) 2008 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <asm/addrspace.h>
 
diff --git a/arch/sh/include/mach-dreamcast/mach/dma.h b/arch/sh/include/mach-dreamcast/mach/dma.h
index 1dbfdf7..a773a76 100644
--- a/arch/sh/include/mach-dreamcast/mach/dma.h
+++ b/arch/sh/include/mach-dreamcast/mach/dma.h
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/dreamcast/dma.h
  *
  * Copyright (C) 2003 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_DREAMCAST_DMA_H
 #define __ASM_SH_DREAMCAST_DMA_H
diff --git a/arch/sh/include/mach-dreamcast/mach/pci.h b/arch/sh/include/mach-dreamcast/mach/pci.h
index 0314d97..c037c1e 100644
--- a/arch/sh/include/mach-dreamcast/mach/pci.h
+++ b/arch/sh/include/mach-dreamcast/mach/pci.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * include/asm-sh/dreamcast/pci.h
  *
  * Copyright (C) 2001, 2002  M. R. Brown
  * Copyright (C) 2002, 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __ASM_SH_DREAMCAST_PCI_H
 #define __ASM_SH_DREAMCAST_PCI_H
diff --git a/arch/sh/include/mach-dreamcast/mach/sysasic.h b/arch/sh/include/mach-dreamcast/mach/sysasic.h
index 58f710e..da10aef 100644
--- a/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ b/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -1,4 +1,6 @@
-/* include/asm-sh/dreamcast/sysasic.h
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * include/asm-sh/dreamcast/sysasic.h
  *
  * Definitions for the Dreamcast System ASIC and related peripherals.
  *
@@ -6,9 +8,6 @@
  * Copyright (C) 2003 Paul Mundt <lethal@linux-sh.org>
  *
  * This file is part of the LinuxDC project (www.linuxdc.org)
- *
- * Released under the terms of the GNU GPL v2.0.
- *
  */
 #ifndef __ASM_SH_DREAMCAST_SYSASIC_H
 #define __ASM_SH_DREAMCAST_SYSASIC_H
diff --git a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
index cc737b8..2d685cc 100644
--- a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
+++ b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
@@ -1,3 +1,4 @@
+LIST "SPDX-License-Identifier: GPL-2.0"
 LIST "partner-jet-setup.txt"
 LIST "(C) Copyright 2009 Renesas Solutions Corp"
 LIST "Kuninori Morimoto <morimoto.kuninori@renesas.com>"
diff --git a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
index 3a65503..a67b192 100644
--- a/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
+++ b/arch/sh/include/mach-kfr2r09/mach/partner-jet-setup.txt
@@ -1,3 +1,4 @@
+LIST "SPDX-License-Identifier: GPL-2.0"
 LIST "partner-jet-setup.txt - 20090729 Magnus Damm"
 LIST "set up enough of the kfr2r09 hardware to boot the kernel"
 
diff --git a/arch/sh/include/mach-se/mach/se7721.h b/arch/sh/include/mach-se/mach/se7721.h
index eabd053..82226d4 100644
--- a/arch/sh/include/mach-se/mach/se7721.h
+++ b/arch/sh/include/mach-se/mach/se7721.h
@@ -1,12 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Copyright (C) 2008 Renesas Solutions Corp.
  *
  * Hitachi UL SolutionEngine 7721 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 
 #ifndef __ASM_SH_SE7721_H
diff --git a/arch/sh/include/mach-se/mach/se7722.h b/arch/sh/include/mach-se/mach/se7722.h
index 637e7ac..efb761f 100644
--- a/arch/sh/include/mach-se/mach/se7722.h
+++ b/arch/sh/include/mach-se/mach/se7722.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_SE7722_H
 #define __ASM_SH_SE7722_H
 
@@ -7,11 +8,6 @@
  * Copyright (C) 2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7722 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/sh_intc.h>
 #include <asm/addrspace.h>
diff --git a/arch/sh/include/mach-se/mach/se7724.h b/arch/sh/include/mach-se/mach/se7724.h
index be842dd..1fe2882 100644
--- a/arch/sh/include/mach-se/mach/se7724.h
+++ b/arch/sh/include/mach-se/mach/se7724.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_SE7724_H
 #define __ASM_SH_SE7724_H
 
@@ -12,11 +13,6 @@
  *
  * Based on se7722.h
  * Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/sh_intc.h>
 #include <asm/addrspace.h>
diff --git a/arch/sh/include/mach-se/mach/se7780.h b/arch/sh/include/mach-se/mach/se7780.h
index bde357c..24f0ac8 100644
--- a/arch/sh/include/mach-se/mach/se7780.h
+++ b/arch/sh/include/mach-se/mach/se7780.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_SH_SE7780_H
 #define __ASM_SH_SE7780_H
 
@@ -7,10 +8,6 @@
  * Copyright (C) 2006,2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7780 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sh_intc.h>
 #include <asm/addrspace.h>
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index ba4d39c..5b45897 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
diff --git a/arch/sh/include/uapi/asm/setup.h b/arch/sh/include/uapi/asm/setup.h
index 552df83..1170dd2 100644
--- a/arch/sh/include/uapi/asm/setup.h
+++ b/arch/sh/include/uapi/asm/setup.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #include <asm-generic/setup.h>
diff --git a/arch/sh/include/uapi/asm/types.h b/arch/sh/include/uapi/asm/types.h
index b9e79bc..f83795f 100644
--- a/arch/sh/include/uapi/asm/types.h
+++ b/arch/sh/include/uapi/asm/types.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #include <asm-generic/types.h>
-- 
2.7.4
