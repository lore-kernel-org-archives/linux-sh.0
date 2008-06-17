From: Adrian Bunk <bunk@kernel.org>
Date: Tue, 17 Jun 2008 22:30:24 +0000
Subject: [2.6 patch] sh: export get_cpu_subtype
Message-Id: <20080617223023.GH25911@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following build error:

<--  snip  -->

...
  MODPOST 1837 modules
ERROR: "get_cpu_subtype" [arch/sh/oprofile/oprofile.ko] undefined!
...
make[2]: *** [__modpost] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
3b4d9e75cf4e2d0eb47bc9e8867a9a60dbd1d8c2 diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index bca2bbc..9324cb9 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -398,6 +398,7 @@ const char *get_cpu_subtype(struct sh_cpuinfo *c)
 {
 	return cpu_name[c->type];
 }
+EXPORT_SYMBOL(get_cpu_subtype);
 
 #ifdef CONFIG_PROC_FS
 /* Symbolic CPU flags, keep in sync with asm/cpu-features.h */

