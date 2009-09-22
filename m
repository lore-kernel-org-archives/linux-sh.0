From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Tue, 22 Sep 2009 13:50:33 +0000
Subject: [PATCH] SH: includecheck fix: dwarf.c
Message-Id: <1253627426.3784.24.camel@ht.satnam>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, Matt Fleming <matt@console-pimps.org>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>


fix the following 'make includecheck' warning:

  arch/sh/kernel/dwarf.c: asm/dwarf.h is included more than once.

Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
---
 arch/sh/kernel/dwarf.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index bc4d8d7..03b3616 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -24,7 +24,6 @@
 #include <asm/unwinder.h>
 #include <asm/sections.h>
 #include <asm/unaligned.h>
-#include <asm/dwarf.h>
 #include <asm/stacktrace.h>
 
 /* Reserve enough memory for two stack frames */
-- 
1.6.0.6


