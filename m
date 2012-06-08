From: Paul Bolle <pebolle@tiscali.nl>
Date: Fri, 08 Jun 2012 20:49:17 +0000
Subject: [PATCH] sh: Kill off last dead UBC header
Message-Id: <1339188557.30984.10.camel@x61.thuisdomein>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Commit 7025bec9125b0a02edcaf22c2dce753bf2c95480 ("sh: Kill off dead UBC
headers.") skipped arch/sh/include/cpu-sh2a/cpu/ubc.h. Since nothing is
using that header either, kill it off too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep" only. Seems obviously correct anyway.

 arch/sh/include/cpu-sh2a/cpu/ubc.h |   28 ----------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)
 delete mode 100644 arch/sh/include/cpu-sh2a/cpu/ubc.h

diff --git a/arch/sh/include/cpu-sh2a/cpu/ubc.h b/arch/sh/include/cpu-sh2a/cpu/ubc.h
deleted file mode 100644
index 1192e1c..0000000
--- a/arch/sh/include/cpu-sh2a/cpu/ubc.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/*
- * SH-2A UBC definitions
- *
- * Copyright (C) 2008 Kieran Bingham
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#ifndef __ASM_CPU_SH2A_UBC_H
-#define __ASM_CPU_SH2A_UBC_H
-
-#define UBC_BARA                0xfffc0400
-#define UBC_BAMRA               0xfffc0404
-#define UBC_BBRA                0xfffc04a0	/* 16 bit access */
-#define UBC_BDRA                0xfffc0408
-#define UBC_BDMRA               0xfffc040c
-
-#define UBC_BARB                0xfffc0410
-#define UBC_BAMRB               0xfffc0414
-#define UBC_BBRB                0xfffc04b0	/* 16 bit access */
-#define UBC_BDRB                0xfffc0418
-#define UBC_BDMRB               0xfffc041c
-
-#define UBC_BRCR                0xfffc04c0
-
-#endif /* __ASM_CPU_SH2A_UBC_H */
-- 
1.7.7.6

