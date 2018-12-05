From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 05 Dec 2018 08:01:00 +0000
Subject: [PATCH 08/13] sh: sh4a: convert to SPDX identifiers
Message-Id: <878t14csxy.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c  | 14 +-------------
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c  | 14 +-------------
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c  | 14 +-------------
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c  | 14 +-------------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c  | 14 +-------------
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/clock-sh7763.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/clock-sh7770.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/clock-sh7780.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/clock-shx3.c    |  5 +----
 arch/sh/kernel/cpu/sh4a/intc-shx3.c     |  5 +----
 arch/sh/kernel/cpu/sh4a/perf_event.c    |  5 +----
 arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c |  5 +----
 arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c |  5 +----
 arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c |  5 +----
 arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c |  5 +----
 arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c |  5 +----
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |  5 +----
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c   |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c  |  7 ++-----
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c  |  5 +----
 arch/sh/kernel/cpu/sh4a/setup-shx3.c    |  5 +----
 arch/sh/kernel/cpu/sh4a/smp-shx3.c      |  5 +----
 arch/sh/kernel/cpu/sh4a/ubc.c           |  5 +----
 37 files changed, 38 insertions(+), 194 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index a907ee2..32cb5d1 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7343.c
  *
  * SH7343 clock framework support
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index ac98541..aa3444b 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7366.c
  *
  * SH7366 clock framework support
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index d85091e..38b0577 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7722.c
  *
  * SH7722 clock framework support
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
index af01664..9dc3a98 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7723.c
  *
  * SH7723 clock framework support
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
index 3194336..2a1f0d8 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7724.c
  *
  * SH7724 clock framework support
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7734.c b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
index 354dcac..c81ee60 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7734.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7734.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2011, 2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  * Copyright (C) 2011, 2012 Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index b10af2a..9acb722 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/clock-sh7757.c
  *
  * SH7757 support for the clock framework
  *
  *  Copyright (C) 2009-2010  Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
index 7707e35a..aaff4b9 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7763.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7763.c
  *
@@ -5,10 +6,6 @@
  *
  *  Copyright (C) 2005  Paul Mundt
  *  Copyright (C) 2007  Yoshihiro Shimoda
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7770.c b/arch/sh/kernel/cpu/sh4a/clock-sh7770.c
index 5d36f33..f356dfc 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7770.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7770.c
  *
  * SH7770 support for the clock framework
  *
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
index 793dae4..fc0a3ef 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7780.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7780.c
  *
  * SH7780 support for the clock framework
  *
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index 1aafd54..fca3513 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7785.c
  *
  * SH7785 support for the clock framework
  *
  *  Copyright (C) 2007 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index ac3dcfe..f23862d 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/clock-sh7786.c
  *
  * SH7786 support for the clock framework
  *
  *  Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index b1bdbc3..6c7b6ab 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/clock-shx3.c
  *
@@ -6,10 +7,6 @@
  *  Copyright (C) 2006-2007  Renesas Technology Corp.
  *  Copyright (C) 2006-2007  Renesas Solutions Corp.
  *  Copyright (C) 2006-2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/intc-shx3.c b/arch/sh/kernel/cpu/sh4a/intc-shx3.c
index 78c9714..eea87d2 100644
--- a/arch/sh/kernel/cpu/sh4a/intc-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/intc-shx3.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Shared support for SH-X3 interrupt controllers.
  *
  *  Copyright (C) 2009 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/irq.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/cpu/sh4a/perf_event.c b/arch/sh/kernel/cpu/sh4a/perf_event.c
index 84a2c39..3beb8fe 100644
--- a/arch/sh/kernel/cpu/sh4a/perf_event.c
+++ b/arch/sh/kernel/cpu/sh4a/perf_event.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance events support for SH-4A performance counters
  *
  *  Copyright (C) 2009, 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
index 99c637d..b67abc0 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7723.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7723 Pinmux
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
index 63be474..b43c325 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7724.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7724 Pinmux
  *
@@ -7,10 +8,6 @@
  *
  * Based on SH7723 Pinmux
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
index ea2db63..46256b1 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7734.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7734 processor support - PFC hardware block
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
  * Copyright (C) 2012  Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/bug.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
index 567745d..c92f304 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7757 (B0 step) Pinmux
  *
@@ -7,10 +8,6 @@
  *
  * Based on SH7723 Pinmux
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
index e336ab8..f329de6 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7785.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7785 Pinmux
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
index 9a45955..47e8639 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7786 Pinmux
  *
@@ -7,10 +8,6 @@
  *  Based on SH7785 pinmux
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
index 444bf25..6c02f62 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH-X3 prototype CPU pinmux
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/bug.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 5788073..a15e256 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7343 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
index 6469187..7bd2776 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7366 Setup
  *
  *  Copyright (C) 2008 Renesas Solutions
  *
  * Based on linux/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 6b3a26e..1ce65f8 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7722 Setup
  *
  *  Copyright (C) 2006 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/mm.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 1c1b3c469..edb6499 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7723 Setup
  *
  *  Copyright (C) 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index c20258b1..3e982503 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7724 Setup
  *
@@ -7,10 +8,6 @@
  *
  * Based on SH7723 Setup
  * Copyright (C) 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
index 8c0c9da..06a9156 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7734.c
@@ -1,14 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/setup-sh7734.c
-
+ *
  * SH7734 Setup
  *
  * Copyright (C) 2011,2012 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
  * Copyright (C) 2011,2012 Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/platform_device.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index a46a19b..2501ce6 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7757 Setup
  *
  * Copyright (C) 2009, 2011  Renesas Solutions Corp.
  *
  *  based on setup-sh7785.c : Copyright (C) 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index 40e6cda..419c5ef 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7763 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
  *  Copyright (C) 2007  Yoshihiro Shimoda
  *  Copyright (C) 2008, 2009  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
index 82e3bdf..5fb4cf9 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7770 Setup
  *
  *  Copyright (C) 2006 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index d90ff67..ab7d6b7 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7780 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index b0d6f82..a438da4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7785 Setup
  *
  *  Copyright (C) 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 17aac38..d894165 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7786 Setup
  *
@@ -8,10 +9,6 @@
  * Based on SH7785 Setup
  *
  *  Copyright (C) 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/setup-shx3.c b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
index ee14d92..14aa455 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-shx3.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH-X3 Prototype Setup
  *
  *  Copyright (C) 2007 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4a/smp-shx3.c b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
index 0d3637c..f8a2bec 100644
--- a/arch/sh/kernel/cpu/sh4a/smp-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/smp-shx3.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH-X3 SMP
  *
  *  Copyright (C) 2007 - 2010  Paul Mundt
  *  Copyright (C) 2007  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4a/ubc.c b/arch/sh/kernel/cpu/sh4a/ubc.c
index efb2745..25eacd9c 100644
--- a/arch/sh/kernel/cpu/sh4a/ubc.c
+++ b/arch/sh/kernel/cpu/sh4a/ubc.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4a/ubc.c
  *
  * On-chip UBC support for SH-4A CPUs.
  *
  * Copyright (C) 2009 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/err.h>
-- 
2.7.4
