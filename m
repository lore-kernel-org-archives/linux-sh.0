From: Tobias Klauser <tklauser@distanz.ch>
Date: Sun, 17 Feb 2008 14:38:35 +0000
Subject: [PATCH] sh: Storage class should be before const qualifier
Message-Id: <20080217143835.GA9231@distanz.ch>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The C99 specification states in section 6.11.5:

The placement of a storage-class specifier other than at the
beginning of the declaration specifiers in a declaration is an
obsolescent feature.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c b/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
index 3feb95a..fb78132 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
@@ -21,8 +21,8 @@
 #include <asm/freq.h>
 #include <asm/io.h>
 
-const static int pll1rate[]={8,12,16,0};
-const static int pfc_divisors[]={1,2,3,4,6,8,12};
+static const int pll1rate[]={8,12,16,0};
+static const int pfc_divisors[]={1,2,3,4,6,8,12};
 #define ifc_divisors pfc_divisors
 
 #if (CONFIG_SH_CLK_MD = 0)
-- 
1.5.4.1

