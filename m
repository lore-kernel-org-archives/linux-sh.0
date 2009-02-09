From: Tobias Klauser <tklauser@distanz.ch>
Date: Mon, 09 Feb 2009 20:59:40 +0000
Subject: [PATCH] sh: Storage class should be before const qualifier
Message-Id: <20090209205940.GA6938@xenon.distanz.ch>
List-Id: <linux-sh.vger.kernel.org>
References: <20080217143835.GA9231@distanz.ch>
In-Reply-To: <20080217143835.GA9231@distanz.ch>
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
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
index 020a96f..4a5e597 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
@@ -18,8 +18,8 @@
 #include <asm/freq.h>
 #include <asm/io.h>
 
-const static int pll1rate[]={1,2,3,4,6,8};
-const static int pfc_divisors[]={1,2,3,4,6,8,12};
+static const int pll1rate[]={1,2,3,4,6,8};
+static const int pfc_divisors[]={1,2,3,4,6,8,12};
 #define ifc_divisors pfc_divisors
 
 #if (CONFIG_SH_CLK_MD = 0)
-- 
1.5.6.5

