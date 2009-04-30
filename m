From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 23:58:00 +0000
Subject: [PATCH 4/7] sh: use new macro for .data.cacheline_aligned section.
Message-Id: <1241135883-9766-5-git-send-email-tabbott@mit.edu>
List-Id: <linux-sh.vger.kernel.org>
References: <1241135883-9766-1-git-send-email-tabbott@mit.edu>
 <1241135883-9766-2-git-send-email-tabbott@mit.edu>
 <1241135883-9766-3-git-send-email-tabbott@mit.edu>
 <1241135883-9766-4-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135883-9766-4-git-send-email-tabbott@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Paul Mundt <lethal@linux-sh.org>, Tim Abbott <tabbott@MIT.EDU>, linux-sh@vger.kernel.org

I moved the section after NOSAVE_DATA with the intention of having the
alignment levels of the sections placed in the .data output section
being strictly decreasing.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/vmlinux_32.lds.S |    4 +---
 arch/sh/kernel/vmlinux_64.lds.S |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/sh/kernel/vmlinux_32.lds.S b/arch/sh/kernel/vmlinux_32.lds.S
index 5f5e190..eabb0bb 100644
--- a/arch/sh/kernel/vmlinux_32.lds.S
+++ b/arch/sh/kernel/vmlinux_32.lds.S
@@ -64,13 +64,11 @@ SECTIONS
 		*(.data.init_task)
 
 		. = ALIGN(L1_CACHE_BYTES);
-		*(.data.cacheline_aligned)
-
-		. = ALIGN(L1_CACHE_BYTES);
 		*(.data.read_mostly)
 
 		PAGE_ALIGNED_DATA
 		NOSAVE_DATA
+		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
 		DATA_DATA
 		CONSTRUCTORS
 	}
diff --git a/arch/sh/kernel/vmlinux_64.lds.S b/arch/sh/kernel/vmlinux_64.lds.S
index 9cccb3d..e0e2e1b 100644
--- a/arch/sh/kernel/vmlinux_64.lds.S
+++ b/arch/sh/kernel/vmlinux_64.lds.S
@@ -73,13 +73,11 @@ SECTIONS
 		*(.data.init_task)
 
 		. = ALIGN(L1_CACHE_BYTES);
-		*(.data.cacheline_aligned)
-
-		. = ALIGN(L1_CACHE_BYTES);
 		*(.data.read_mostly)
 
 		PAGE_ALIGNED_DATA
 		NOSAVE_DATA
+		CACHELINE_ALIGNED_DATA(L1_CACHE_BYTES)
 		DATA_DATA
 		CONSTRUCTORS
 	}
-- 
1.6.2.1

