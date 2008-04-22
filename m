From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Date: Tue, 22 Apr 2008 17:24:12 +0000
Subject: [RFC patch 8/9] SH remove -traditional
Message-Id: <20080422172843.205481136@polymtl.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <20080422172404.502954084@polymtl.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, akpm@linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, lethal@linux-sh.org, linux-sh@vger.kernel.org

Subject: [RFC patch 8/9] Re: [PATCH] Stringify support commas
 > This is a no-no for those archs that still use -traditional.
 > > I dunno if this is a problem for you at the moment and the
 > > right fix is anyway to nuke -traditional.
 > > 
 > >     Sam

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Sam Ravnborg <sam@ravnborg.org>
CC: lethal@linux-sh.org
CC: linux-sh@vger.kernel.org
---
 arch/sh/boot/compressed/Makefile_32 |    1 -
 arch/sh/boot/compressed/Makefile_64 |    1 -
 2 files changed, 2 deletions(-)

Index: linux-2.6-lttng/arch/sh/boot/compressed/Makefile_32
=================================--- linux-2.6-lttng.orig/arch/sh/boot/compressed/Makefile_32	2008-04-21 10:07:12.000000000 -0400
+++ linux-2.6-lttng/arch/sh/boot/compressed/Makefile_32	2008-04-21 10:07:17.000000000 -0400
@@ -6,7 +6,6 @@
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz \
 		   head_32.o misc_32.o piggy.o
-EXTRA_AFLAGS	:= -traditional
 
 OBJECTS = $(obj)/head_32.o $(obj)/misc_32.o
 
Index: linux-2.6-lttng/arch/sh/boot/compressed/Makefile_64
=================================--- linux-2.6-lttng.orig/arch/sh/boot/compressed/Makefile_64	2008-04-21 10:07:12.000000000 -0400
+++ linux-2.6-lttng/arch/sh/boot/compressed/Makefile_64	2008-04-21 10:07:17.000000000 -0400
@@ -13,7 +13,6 @@
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz \
 		   head_64.o misc_64.o cache.o piggy.o
-EXTRA_AFLAGS	:= -traditional
 
 OBJECTS		:= $(obj)/vmlinux_64.lds $(obj)/head_64.o $(obj)/misc_64.o \
 		   $(obj)/cache.o

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
