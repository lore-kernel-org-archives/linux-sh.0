From: Nishad Kamdar <nishadkamdar@gmail.com>
Date: Tue, 16 Apr 2019 15:43:49 +0000
Subject: [PATCH v3 4/5] sh: Use the correct style for SPDX License Identifier
Message-Id: <da0b15850aecb1bc984f25ef597311b8fc24241e.1555427420.git.nishadkamdar@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1555427418.git.nishadkamdar@gmail.com>
In-Reply-To: <cover.1555427418.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joe Perches <joe@perches.com>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style
in the SuperH Hardware Architecture related files.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 arch/sh/drivers/pci/pci-sh5.h                     | 4 ++--
 arch/sh/drivers/pci/pci-sh7751.h                  | 4 ++--
 arch/sh/drivers/pci/pci-sh7780.h                  | 4 ++--
 arch/sh/drivers/pci/pcie-sh7786.h                 | 4 ++--
 arch/sh/include/asm/addrspace.h                   | 4 ++--
 arch/sh/include/asm/bl_bit_64.h                   | 4 ++--
 arch/sh/include/asm/cache_insns_64.h              | 4 ++--
 arch/sh/include/asm/device.h                      | 4 ++--
 arch/sh/include/asm/dma-register.h                | 4 ++--
 arch/sh/include/asm/dma.h                         | 4 ++--
 arch/sh/include/asm/dwarf.h                       | 4 ++--
 arch/sh/include/asm/fixmap.h                      | 4 ++--
 arch/sh/include/asm/flat.h                        | 4 ++--
 arch/sh/include/asm/freq.h                        | 4 ++--
 arch/sh/include/asm/gpio.h                        | 4 ++--
 arch/sh/include/asm/machvec.h                     | 4 ++--
 arch/sh/include/asm/pgtable.h                     | 4 ++--
 arch/sh/include/asm/sfp-machine.h                 | 4 ++--
 arch/sh/include/asm/shmparam.h                    | 4 ++--
 arch/sh/include/asm/siu.h                         | 4 ++--
 arch/sh/include/asm/spinlock-cas.h                | 4 ++--
 arch/sh/include/asm/spinlock-llsc.h               | 4 ++--
 arch/sh/include/asm/spinlock.h                    | 4 ++--
 arch/sh/include/asm/switch_to.h                   | 4 ++--
 arch/sh/include/asm/switch_to_64.h                | 4 ++--
 arch/sh/include/asm/tlb_64.h                      | 4 ++--
 arch/sh/include/asm/traps_64.h                    | 4 ++--
 arch/sh/include/asm/watchdog.h                    | 4 ++--
 arch/sh/include/cpu-common/cpu/addrspace.h        | 4 ++--
 arch/sh/include/cpu-common/cpu/mmu_context.h      | 4 ++--
 arch/sh/include/cpu-common/cpu/pfc.h              | 4 ++--
 arch/sh/include/cpu-sh2/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh2/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh2/cpu/watchdog.h            | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/cache.h              | 4 ++--
 arch/sh/include/cpu-sh2a/cpu/freq.h               | 4 ++--
 arch/sh/include/cpu-sh3/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh3/cpu/dma-register.h        | 4 ++--
 arch/sh/include/cpu-sh3/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh3/cpu/gpio.h                | 4 ++--
 arch/sh/include/cpu-sh3/cpu/mmu_context.h         | 4 ++--
 arch/sh/include/cpu-sh3/cpu/watchdog.h            | 4 ++--
 arch/sh/include/cpu-sh4/cpu/addrspace.h           | 4 ++--
 arch/sh/include/cpu-sh4/cpu/cache.h               | 4 ++--
 arch/sh/include/cpu-sh4/cpu/dma-register.h        | 4 ++--
 arch/sh/include/cpu-sh4/cpu/fpu.h                 | 4 ++--
 arch/sh/include/cpu-sh4/cpu/freq.h                | 4 ++--
 arch/sh/include/cpu-sh4/cpu/mmu_context.h         | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sh7786.h              | 4 ++--
 arch/sh/include/cpu-sh4/cpu/sq.h                  | 4 ++--
 arch/sh/include/cpu-sh4/cpu/watchdog.h            | 4 ++--
 arch/sh/include/mach-common/mach/hp6xx.h          | 4 ++--
 arch/sh/include/mach-common/mach/magicpanelr2.h   | 4 ++--
 arch/sh/include/mach-common/mach/mangle-port.h    | 4 ++--
 arch/sh/include/mach-common/mach/microdev.h       | 4 ++--
 arch/sh/include/mach-common/mach/secureedge5410.h | 4 ++--
 arch/sh/include/mach-dreamcast/mach/dma.h         | 4 ++--
 arch/sh/include/mach-dreamcast/mach/pci.h         | 4 ++--
 arch/sh/include/mach-dreamcast/mach/sysasic.h     | 4 ++--
 arch/sh/include/mach-se/mach/se7721.h             | 4 ++--
 60 files changed, 120 insertions(+), 120 deletions(-)

diff --git a/arch/sh/drivers/pci/pci-sh5.h b/arch/sh/drivers/pci/pci-sh5.h
index 91348af0ef6c..0d2c093fd984 100644
--- a/arch/sh/drivers/pci/pci-sh5.h
+++ b/arch/sh/drivers/pci/pci-sh5.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  *
  * Definitions for the SH5 PCI hardware.
diff --git a/arch/sh/drivers/pci/pci-sh7751.h b/arch/sh/drivers/pci/pci-sh7751.h
index d1951e50effc..9e23cf7113ac 100644
--- a/arch/sh/drivers/pci/pci-sh7751.h
+++ b/arch/sh/drivers/pci/pci-sh7751.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *	Low-Level PCI Support for SH7751 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/drivers/pci/pci-sh7780.h
index e2ac770f8e35..7ba87b62e439 100644
--- a/arch/sh/drivers/pci/pci-sh7780.h
+++ b/arch/sh/drivers/pci/pci-sh7780.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *	Low-Level PCI Support for SH7780 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
diff --git a/arch/sh/drivers/pci/pcie-sh7786.h b/arch/sh/drivers/pci/pcie-sh7786.h
index ffe383681a0b..c5e2221b6359 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.h
+++ b/arch/sh/drivers/pci/pcie-sh7786.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH7786 PCI-Express controller definitions.
  *
  * Copyright (C) 2008, 2009 Renesas Technology Corp.
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 34bfbcddcce0..c663527cab7c 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 1999 by Kaz Kojima
  *
  * Defitions for the address spaces of the SH CPUs.
diff --git a/arch/sh/include/asm/bl_bit_64.h b/arch/sh/include/asm/bl_bit_64.h
index aac9780fe864..c6032f194f4c 100644
--- a/arch/sh/include/asm/bl_bit_64.h
+++ b/arch/sh/include/asm/bl_bit_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/cache_insns_64.h b/arch/sh/include/asm/cache_insns_64.h
index ed682b987b0d..768f18aae612 100644
--- a/arch/sh/include/asm/cache_insns_64.h
+++ b/arch/sh/include/asm/cache_insns_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/device.h b/arch/sh/include/asm/device.h
index 6f3e686a1c6f..75e0f44f8969 100644
--- a/arch/sh/include/asm/device.h
+++ b/arch/sh/include/asm/device.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Arch specific extensions to struct device
  */
 #ifndef __ASM_SH_DEVICE_H
diff --git a/arch/sh/include/asm/dma-register.h b/arch/sh/include/asm/dma-register.h
index 724dab912b71..96fed7b02b0f 100644
--- a/arch/sh/include/asm/dma-register.h
+++ b/arch/sh/include/asm/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Common header for the legacy SH DMA driver and the new dmaengine driver
  *
  * extracted from arch/sh/include/asm/dma-sh.h:
diff --git a/arch/sh/include/asm/dma.h b/arch/sh/include/asm/dma.h
index 4d5a21a891c0..faa1b66b9397 100644
--- a/arch/sh/include/asm/dma.h
+++ b/arch/sh/include/asm/dma.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dma.h
  *
  * Copyright (C) 2003, 2004  Paul Mundt
diff --git a/arch/sh/include/asm/dwarf.h b/arch/sh/include/asm/dwarf.h
index 571954474122..661d1b9f07d4 100644
--- a/arch/sh/include/asm/dwarf.h
+++ b/arch/sh/include/asm/dwarf.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2009 Matt Fleming <matt@console-pimps.org>
  */
 #ifndef __ASM_SH_DWARF_H
diff --git a/arch/sh/include/asm/fixmap.h b/arch/sh/include/asm/fixmap.h
index e30348c58073..15abcd96f4b2 100644
--- a/arch/sh/include/asm/fixmap.h
+++ b/arch/sh/include/asm/fixmap.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * fixmap.h: compile-time virtual memory allocation
  *
  * Copyright (C) 1998 Ingo Molnar
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 843d458b8329..6adbdfda6951 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/flat.h
  *
  * uClinux flat-format executables
diff --git a/arch/sh/include/asm/freq.h b/arch/sh/include/asm/freq.h
index 18133bf83738..693183a63bfb 100644
--- a/arch/sh/include/asm/freq.h
+++ b/arch/sh/include/asm/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/asm-sh/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/gpio.h b/arch/sh/include/asm/gpio.h
index 351918894e86..18319e97a5ec 100644
--- a/arch/sh/include/asm/gpio.h
+++ b/arch/sh/include/asm/gpio.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/gpio.h
  *
  * Generic GPIO API and pinmux table support for SuperH.
diff --git a/arch/sh/include/asm/machvec.h b/arch/sh/include/asm/machvec.h
index f7d05546beca..76c528b8df83 100644
--- a/arch/sh/include/asm/machvec.h
+++ b/arch/sh/include/asm/machvec.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/machvec.h
  *
  * Copyright 2000 Stuart Menefy (stuart.menefy@st.com)
diff --git a/arch/sh/include/asm/pgtable.h b/arch/sh/include/asm/pgtable.h
index 3587103afe59..daa593d9f81f 100644
--- a/arch/sh/include/asm/pgtable.h
+++ b/arch/sh/include/asm/pgtable.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * This file contains the functions and defines necessary to modify and
  * use the SuperH page table tree.
  *
diff --git a/arch/sh/include/asm/sfp-machine.h b/arch/sh/include/asm/sfp-machine.h
index cbc7cf8c97ce..77b40ceec36c 100644
--- a/arch/sh/include/asm/sfp-machine.h
+++ b/arch/sh/include/asm/sfp-machine.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * Machine-dependent software floating-point definitions.
    SuperH kernel version.
    Copyright (C) 1997,1998,1999 Free Software Foundation, Inc.
diff --git a/arch/sh/include/asm/shmparam.h b/arch/sh/include/asm/shmparam.h
index 6c580a644a78..4a83ec04128a 100644
--- a/arch/sh/include/asm/shmparam.h
+++ b/arch/sh/include/asm/shmparam.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/shmparam.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
index 35e4839d381e..1af6844b1f00 100644
--- a/arch/sh/include/asm/siu.h
+++ b/arch/sh/include/asm/siu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * platform header for the SIU ASoC driver
  *
  * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/asm/spinlock-cas.h b/arch/sh/include/asm/spinlock-cas.h
index 3d49985ebf41..c9ed7492dd5d 100644
--- a/arch/sh/include/asm/spinlock-cas.h
+++ b/arch/sh/include/asm/spinlock-cas.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock-cas.h
  *
  * Copyright (C) 2015 SEI
diff --git a/arch/sh/include/asm/spinlock-llsc.h b/arch/sh/include/asm/spinlock-llsc.h
index 7fd929cd2e7a..4ba23555c026 100644
--- a/arch/sh/include/asm/spinlock-llsc.h
+++ b/arch/sh/include/asm/spinlock-llsc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock-llsc.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/spinlock.h b/arch/sh/include/asm/spinlock.h
index fa6801f63551..6cc36df2ddd3 100644
--- a/arch/sh/include/asm/spinlock.h
+++ b/arch/sh/include/asm/spinlock.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/spinlock.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/asm/switch_to.h b/arch/sh/include/asm/switch_to.h
index 9eec80ab5aa2..3fe65cf11319 100644
--- a/arch/sh/include/asm/switch_to.h
+++ b/arch/sh/include/asm/switch_to.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/switch_to_64.h b/arch/sh/include/asm/switch_to_64.h
index 2dbf2311669f..87a08602f1c9 100644
--- a/arch/sh/include/asm/switch_to_64.h
+++ b/arch/sh/include/asm/switch_to_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/tlb_64.h b/arch/sh/include/asm/tlb_64.h
index 59fa0a23dad7..dac46f8c5216 100644
--- a/arch/sh/include/asm/tlb_64.h
+++ b/arch/sh/include/asm/tlb_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/tlb_64.h
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/asm/traps_64.h b/arch/sh/include/asm/traps_64.h
index f28db6dfbe45..7e5e902d2278 100644
--- a/arch/sh/include/asm/traps_64.h
+++ b/arch/sh/include/asm/traps_64.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
diff --git a/arch/sh/include/asm/watchdog.h b/arch/sh/include/asm/watchdog.h
index cecd0fc507f9..6f64666186c2 100644
--- a/arch/sh/include/asm/watchdog.h
+++ b/arch/sh/include/asm/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0+
- *
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
  * include/asm-sh/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/addrspace.h b/arch/sh/include/cpu-common/cpu/addrspace.h
index d8bf5d7d2fdf..2c0f54e68bb2 100644
--- a/arch/sh/include/cpu-common/cpu/addrspace.h
+++ b/arch/sh/include/cpu-common/cpu/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Definitions for the address spaces of the SH-2 CPUs.
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/mmu_context.h b/arch/sh/include/cpu-common/cpu/mmu_context.h
index cef3a30dbf97..0f2602e1c963 100644
--- a/arch/sh/include/cpu-common/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-common/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/mmu_context.h
  *
  * Copyright (C) 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-common/cpu/pfc.h b/arch/sh/include/cpu-common/cpu/pfc.h
index 879d2c9da537..8ca16923cc40 100644
--- a/arch/sh/include/cpu-common/cpu/pfc.h
+++ b/arch/sh/include/cpu-common/cpu/pfc.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH Pin Function Control Initialization
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
diff --git a/arch/sh/include/cpu-sh2/cpu/cache.h b/arch/sh/include/cpu-sh2/cpu/cache.h
index 070aa9f50d3f..9508876fede0 100644
--- a/arch/sh/include/cpu-sh2/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/cache.h
  *
  * Copyright (C) 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2/cpu/freq.h b/arch/sh/include/cpu-sh2/cpu/freq.h
index fb2e5d2831bc..a598fba55059 100644
--- a/arch/sh/include/cpu-sh2/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
diff --git a/arch/sh/include/cpu-sh2/cpu/watchdog.h b/arch/sh/include/cpu-sh2/cpu/watchdog.h
index 141fe296d751..ef3941c3b726 100644
--- a/arch/sh/include/cpu-sh2/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh2/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2a/cpu/cache.h b/arch/sh/include/cpu-sh2a/cpu/cache.h
index 06efb233eb35..259e4cbc4131 100644
--- a/arch/sh/include/cpu-sh2a/cpu/cache.h
+++ b/arch/sh/include/cpu-sh2a/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2a/cache.h
  *
  * Copyright (C) 2004 Paul Mundt
diff --git a/arch/sh/include/cpu-sh2a/cpu/freq.h b/arch/sh/include/cpu-sh2a/cpu/freq.h
index fb0813f47043..a637324e0f43 100644
--- a/arch/sh/include/cpu-sh2a/cpu/freq.h
+++ b/arch/sh/include/cpu-sh2a/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh2a/freq.h
  *
  * Copyright (C) 2006  Yoshinori Sato
diff --git a/arch/sh/include/cpu-sh3/cpu/cache.h b/arch/sh/include/cpu-sh3/cpu/cache.h
index f57124826943..99f53e41e781 100644
--- a/arch/sh/include/cpu-sh3/cpu/cache.h
+++ b/arch/sh/include/cpu-sh3/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh3/cpu/dma-register.h b/arch/sh/include/cpu-sh3/cpu/dma-register.h
index c0f921fb4edc..efc3632756bf 100644
--- a/arch/sh/include/cpu-sh3/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh3/cpu/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH3 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/cpu-sh3/cpu/freq.h b/arch/sh/include/cpu-sh3/cpu/freq.h
index 7290f02b7173..5968337d7e84 100644
--- a/arch/sh/include/cpu-sh3/cpu/freq.h
+++ b/arch/sh/include/cpu-sh3/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh3/cpu/gpio.h b/arch/sh/include/cpu-sh3/cpu/gpio.h
index aeb0588ace98..391d55f4b689 100644
--- a/arch/sh/include/cpu-sh3/cpu/gpio.h
+++ b/arch/sh/include/cpu-sh3/cpu/gpio.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/cpu-sh3/gpio.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
diff --git a/arch/sh/include/cpu-sh3/cpu/mmu_context.h b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
index ead9a6f72113..45a3ac26a6c5 100644
--- a/arch/sh/include/cpu-sh3/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh3/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh3/cpu/watchdog.h b/arch/sh/include/cpu-sh3/cpu/watchdog.h
index 9d7e9d986809..406f770f956a 100644
--- a/arch/sh/include/cpu-sh3/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh3/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh3/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/addrspace.h b/arch/sh/include/cpu-sh4/cpu/addrspace.h
index f006c9489f5a..92a6e0348e70 100644
--- a/arch/sh/include/cpu-sh4/cpu/addrspace.h
+++ b/arch/sh/include/cpu-sh4/cpu/addrspace.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 1999 by Kaz Kojima
  *
  * Defitions for the address spaces of the SH-4 CPUs.
diff --git a/arch/sh/include/cpu-sh4/cpu/cache.h b/arch/sh/include/cpu-sh4/cpu/cache.h
index 72b4d13da127..a2a0f2739ce4 100644
--- a/arch/sh/include/cpu-sh4/cpu/cache.h
+++ b/arch/sh/include/cpu-sh4/cpu/cache.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/cache.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 53f7ab990d88..4a284e70a757 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH4 CPU-specific DMA definitions, used by both DMA drivers
  *
  * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
diff --git a/arch/sh/include/cpu-sh4/cpu/fpu.h b/arch/sh/include/cpu-sh4/cpu/fpu.h
index 29f451bfef19..7722f23b6118 100644
--- a/arch/sh/include/cpu-sh4/cpu/fpu.h
+++ b/arch/sh/include/cpu-sh4/cpu/fpu.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/arch/sh/kernel/cpu/sh4/sh4_fpu.h
  *
  * Copyright (C) 2006 STMicroelectronics Limited
diff --git a/arch/sh/include/cpu-sh4/cpu/freq.h b/arch/sh/include/cpu-sh4/cpu/freq.h
index 662f0f30e106..5d9cdaa0c4ba 100644
--- a/arch/sh/include/cpu-sh4/cpu/freq.h
+++ b/arch/sh/include/cpu-sh4/cpu/freq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/freq.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/mmu_context.h b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
index 421b56d5c595..df5335e9e80f 100644
--- a/arch/sh/include/cpu-sh4/cpu/mmu_context.h
+++ b/arch/sh/include/cpu-sh4/cpu/mmu_context.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/mmu_context.h
  *
  * Copyright (C) 1999 Niibe Yutaka
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7786.h b/arch/sh/include/cpu-sh4/cpu/sh7786.h
index d6cce65b4871..b6e910bdcf8b 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7786.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7786.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH7786 Pinmux
  *
  * Copyright (C) 2008, 2009  Renesas Solutions Corp.
diff --git a/arch/sh/include/cpu-sh4/cpu/sq.h b/arch/sh/include/cpu-sh4/cpu/sq.h
index 81966e41fc21..91f6b1022e5f 100644
--- a/arch/sh/include/cpu-sh4/cpu/sq.h
+++ b/arch/sh/include/cpu-sh4/cpu/sq.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/sq.h
  *
  * Copyright (C) 2001, 2002, 2003  Paul Mundt
diff --git a/arch/sh/include/cpu-sh4/cpu/watchdog.h b/arch/sh/include/cpu-sh4/cpu/watchdog.h
index fa7bcb398b8c..5190f7a8ed99 100644
--- a/arch/sh/include/cpu-sh4/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh4/cpu/watchdog.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/cpu-sh4/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
diff --git a/arch/sh/include/mach-common/mach/hp6xx.h b/arch/sh/include/mach-common/mach/hp6xx.h
index 71241f0d02a1..10e8c4cf2247 100644
--- a/arch/sh/include/mach-common/mach/hp6xx.h
+++ b/arch/sh/include/mach-common/mach/hp6xx.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2003, 2004, 2005  Andriy Skulysh
  */
 #ifndef __ASM_SH_HP6XX_H
diff --git a/arch/sh/include/mach-common/mach/magicpanelr2.h b/arch/sh/include/mach-common/mach/magicpanelr2.h
index c2d218cea74b..ee8a76c4e21f 100644
--- a/arch/sh/include/mach-common/mach/magicpanelr2.h
+++ b/arch/sh/include/mach-common/mach/magicpanelr2.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  *  include/asm-sh/magicpanelr2.h
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
diff --git a/arch/sh/include/mach-common/mach/mangle-port.h b/arch/sh/include/mach-common/mach/mangle-port.h
index dd5a761a52ee..3cca842fd1d2 100644
--- a/arch/sh/include/mach-common/mach/mangle-port.h
+++ b/arch/sh/include/mach-common/mach/mangle-port.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * SH version cribbed from the MIPS copy:
  *
  * Copyright (C) 2003, 2004 Ralf Baechle
diff --git a/arch/sh/include/mach-common/mach/microdev.h b/arch/sh/include/mach-common/mach/microdev.h
index 0e2f9ab11976..38c4120bf439 100644
--- a/arch/sh/include/mach-common/mach/microdev.h
+++ b/arch/sh/include/mach-common/mach/microdev.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * linux/include/asm-sh/microdev.h
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
diff --git a/arch/sh/include/mach-common/mach/secureedge5410.h b/arch/sh/include/mach-common/mach/secureedge5410.h
index dfc68aa91003..d0be04b6cd38 100644
--- a/arch/sh/include/mach-common/mach/secureedge5410.h
+++ b/arch/sh/include/mach-common/mach/secureedge5410.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/snapgear.h
  *
  * Modified version of io_se.h for the snapgear-specific functions.
diff --git a/arch/sh/include/mach-dreamcast/mach/dma.h b/arch/sh/include/mach-dreamcast/mach/dma.h
index a773a763843a..40537ca3c110 100644
--- a/arch/sh/include/mach-dreamcast/mach/dma.h
+++ b/arch/sh/include/mach-dreamcast/mach/dma.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/dma.h
  *
  * Copyright (C) 2003 Paul Mundt
diff --git a/arch/sh/include/mach-dreamcast/mach/pci.h b/arch/sh/include/mach-dreamcast/mach/pci.h
index c037c1ec63a9..fec7f8aa9c5b 100644
--- a/arch/sh/include/mach-dreamcast/mach/pci.h
+++ b/arch/sh/include/mach-dreamcast/mach/pci.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/pci.h
  *
  * Copyright (C) 2001, 2002  M. R. Brown
diff --git a/arch/sh/include/mach-dreamcast/mach/sysasic.h b/arch/sh/include/mach-dreamcast/mach/sysasic.h
index ed69ce7f2030..03daca6ea92b 100644
--- a/arch/sh/include/mach-dreamcast/mach/sysasic.h
+++ b/arch/sh/include/mach-dreamcast/mach/sysasic.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * include/asm-sh/dreamcast/sysasic.h
  *
  * Definitions for the Dreamcast System ASIC and related peripherals.
diff --git a/arch/sh/include/mach-se/mach/se7721.h b/arch/sh/include/mach-se/mach/se7721.h
index 82226d40faf5..b1940b6f9649 100644
--- a/arch/sh/include/mach-se/mach/se7721.h
+++ b/arch/sh/include/mach-se/mach/se7721.h
@@ -1,5 +1,5 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
  * Copyright (C) 2008 Renesas Solutions Corp.
  *
  * Hitachi UL SolutionEngine 7721 Support.
-- 
2.17.1
