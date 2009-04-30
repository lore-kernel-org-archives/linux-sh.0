From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 23:57:59 +0000
Subject: [PATCH 3/7] sh: use NOSAVE_DATA macro for .data.nosave section.
Message-Id: <1241135883-9766-4-git-send-email-tabbott@mit.edu>
List-Id: <linux-sh.vger.kernel.org>
References: <1241135883-9766-1-git-send-email-tabbott@mit.edu>
 <1241135883-9766-2-git-send-email-tabbott@mit.edu>
 <1241135883-9766-3-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135883-9766-3-git-send-email-tabbott@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, Paul Mundt <lethal@linux-sh.org>, Tim Abbott <tabbott@MIT.EDU>, linux-sh@vger.kernel.org

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/vmlinux_32.lds.S |    7 +------
 arch/sh/kernel/vmlinux_64.lds.S |    7 +------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/sh/kernel/vmlinux_32.lds.S b/arch/sh/kernel/vmlinux_32.lds.S
index 325af0b..5f5e190 100644
--- a/arch/sh/kernel/vmlinux_32.lds.S
+++ b/arch/sh/kernel/vmlinux_32.lds.S
@@ -70,12 +70,7 @@ SECTIONS
 		*(.data.read_mostly)
 
 		PAGE_ALIGNED_DATA
-
-		__nosave_begin = .;
-		*(.data.nosave)
-		. = ALIGN(PAGE_SIZE);
-		__nosave_end = .;
-
+		NOSAVE_DATA
 		DATA_DATA
 		CONSTRUCTORS
 	}
diff --git a/arch/sh/kernel/vmlinux_64.lds.S b/arch/sh/kernel/vmlinux_64.lds.S
index b222700..9cccb3d 100644
--- a/arch/sh/kernel/vmlinux_64.lds.S
+++ b/arch/sh/kernel/vmlinux_64.lds.S
@@ -79,12 +79,7 @@ SECTIONS
 		*(.data.read_mostly)
 
 		PAGE_ALIGNED_DATA
-
-		__nosave_begin = .;
-		*(.data.nosave)
-		. = ALIGN(PAGE_SIZE);
-		__nosave_end = .;
-
+		NOSAVE_DATA
 		DATA_DATA
 		CONSTRUCTORS
 	}
-- 
1.6.2.1

