From: David Howells <dhowells@redhat.com>
Date: Wed, 17 Oct 2012 14:01:42 +0000
Subject: [PATCH 09/10] UAPI: Make arch/sh/include/uapi/asm/hw_breakpoint.h non-empty
Message-Id: <20121017140142.28541.69603.stgit@warthog.procyon.org.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

arch/sh/include/uapi/asm/hw_breakpoint.h was emitted by the UAPI disintegration
script as an empty file because the parent file had no UAPI stuff in it,
despite being marked with "header-y".

Unfortunately, the patch program deletes resultant empty files when applying a
kernel patch.

So just stick a comment in there as a placeholder.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Paul Mundt <lethal@linux-sh.org>
cc: linux-sh@vger.kernel.org
---

 arch/sh/include/uapi/asm/hw_breakpoint.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sh/include/uapi/asm/hw_breakpoint.h b/arch/sh/include/uapi/asm/hw_breakpoint.h
index e69de29..ae5704f 100644
--- a/arch/sh/include/uapi/asm/hw_breakpoint.h
+++ b/arch/sh/include/uapi/asm/hw_breakpoint.h
@@ -0,0 +1,4 @@
+/*
+ * There isn't anything here anymore, but the file must not be empty or patch
+ * will delete it.
+ */

