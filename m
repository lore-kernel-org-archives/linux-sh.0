From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 23 Aug 2018 02:53:31 +0000
Subject: [PATCH v2 13/13] sh: lib: convert to SPDX identifiers
Message-Id: <871sapdckc.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87k1ohdcqu.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1ohdcqu.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/lib/ashiftrt.S       | 29 ++++-------------------------
 arch/sh/lib/ashlsi3.S        | 29 ++++-------------------------
 arch/sh/lib/ashrsi3.S        | 29 ++++-------------------------
 arch/sh/lib/checksum.S       |  9 +++------
 arch/sh/lib/io.c             |  5 +----
 arch/sh/lib/libgcc.h         |  2 ++
 arch/sh/lib/lshrsi3.S        | 29 ++++-------------------------
 arch/sh/lib/mcount.S         |  7 ++-----
 arch/sh/lib/movmem.S         | 29 ++++-------------------------
 arch/sh/lib/udiv_qrnnd.S     | 29 ++++-------------------------
 arch/sh/lib/udivsi3.S        | 29 ++++-------------------------
 arch/sh/lib/udivsi3_i4i-Os.S | 29 ++++-------------------------
 arch/sh/lib/udivsi3_i4i.S    | 29 ++++-------------------------
 13 files changed, 44 insertions(+), 240 deletions(-)

diff --git a/arch/sh/lib/ashiftrt.S b/arch/sh/lib/ashiftrt.S
index 45ce865..0f7145e 100644
--- a/arch/sh/lib/ashiftrt.S
+++ b/arch/sh/lib/ashiftrt.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/ashlsi3.S b/arch/sh/lib/ashlsi3.S
index 70a6434..4df4401 100644
--- a/arch/sh/lib/ashlsi3.S
+++ b/arch/sh/lib/ashlsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/ashrsi3.S b/arch/sh/lib/ashrsi3.S
index 602599d..bf3c4e03 100644
--- a/arch/sh/lib/ashrsi3.S
+++ b/arch/sh/lib/ashrsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 356c8ec9..97b5c2d 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -1,4 +1,6 @@
-/* $Id: checksum.S,v 1.10 2001/07/06 13:11:32 gniibe Exp $
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * $Id: checksum.S,v 1.10 2001/07/06 13:11:32 gniibe Exp $
  *
  * INET		An implementation of the TCP/IP protocol suite for the LINUX
  *		operating system.  INET is implemented using the  BSD Socket
@@ -21,11 +23,6 @@
  *                   converted to pure assembler
  *
  * SuperH version:  Copyright (C) 1999  Niibe Yutaka
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
  */
 
 #include <asm/errno.h>
diff --git a/arch/sh/lib/io.c b/arch/sh/lib/io.c
index 88dfe6e..ebcf7c0 100644
--- a/arch/sh/lib/io.c
+++ b/arch/sh/lib/io.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/lib/io.c - SH32 optimized I/O routines
  *
@@ -6,10 +7,6 @@
  *
  * Provide real functions which expand to whatever the header file defined.
  * Also definitions of machine independent IO functions.
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/io.h>
diff --git a/arch/sh/lib/libgcc.h b/arch/sh/lib/libgcc.h
index 05909d58..58ada9e 100644
--- a/arch/sh/lib/libgcc.h
+++ b/arch/sh/lib/libgcc.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef __ASM_LIBGCC_H
 #define __ASM_LIBGCC_H
 
diff --git a/arch/sh/lib/lshrsi3.S b/arch/sh/lib/lshrsi3.S
index f2a6959..b79b817 100644
--- a/arch/sh/lib/lshrsi3.S
+++ b/arch/sh/lib/lshrsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/mcount.S b/arch/sh/lib/mcount.S
index 7a8572f..c6ca90c 100644
--- a/arch/sh/lib/mcount.S
+++ b/arch/sh/lib/mcount.S
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/lib/mcount.S
  *
  *  Copyright (C) 2008, 2009  Paul Mundt
  *  Copyright (C) 2008, 2009  Matt Fleming
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <asm/ftrace.h>
 #include <asm/thread_info.h>
diff --git a/arch/sh/lib/movmem.S b/arch/sh/lib/movmem.S
index 62075f6..8ac54d6 100644
--- a/arch/sh/lib/movmem.S
+++ b/arch/sh/lib/movmem.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/udiv_qrnnd.S b/arch/sh/lib/udiv_qrnnd.S
index 32b9a36..28938da 100644
--- a/arch/sh/lib/udiv_qrnnd.S
+++ b/arch/sh/lib/udiv_qrnnd.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/udivsi3.S b/arch/sh/lib/udivsi3.S
index 72157ab..09ed1f9 100644
--- a/arch/sh/lib/udivsi3.S
+++ b/arch/sh/lib/udivsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/udivsi3_i4i-Os.S b/arch/sh/lib/udivsi3_i4i-Os.S
index 4835553e..fa4e4df 100644
--- a/arch/sh/lib/udivsi3_i4i-Os.S
+++ b/arch/sh/lib/udivsi3_i4i-Os.S
@@ -1,28 +1,7 @@
-/* Copyright (C) 2006 Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+ *
+ * Copyright (C) 2006 Free Software Foundation, Inc.
+ */
 
 /* Moderately Space-optimized libgcc routines for the Renesas SH /
    STMicroelectronics ST40 CPUs.
diff --git a/arch/sh/lib/udivsi3_i4i.S b/arch/sh/lib/udivsi3_i4i.S
index f1a79d9..6944eb6 100644
--- a/arch/sh/lib/udivsi3_i4i.S
+++ b/arch/sh/lib/udivsi3_i4i.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
 
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
-- 
2.7.4
