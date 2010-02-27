From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sat, 27 Feb 2010 16:51:23 +0000
Subject: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Message-Id: <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, linux-mips@linux-mips.org, linux-sh@vger.kernel.org

arch/mips/lib/libgcc.h:21: ERROR: open brace '{' following union go on the same line

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/lib/libgcc.h |    3 +--
 arch/sh/lib/libgcc.h   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/libgcc.h b/arch/mips/lib/libgcc.h
index 3f19d1c..05909d5 100644
--- a/arch/mips/lib/libgcc.h
+++ b/arch/mips/lib/libgcc.h
@@ -17,8 +17,7 @@ struct DWstruct {
 #error I feel sick.
 #endif
 
-typedef union
-{
+typedef union {
 	struct DWstruct s;
 	long long ll;
 } DWunion;
diff --git a/arch/sh/lib/libgcc.h b/arch/sh/lib/libgcc.h
index 3f19d1c..05909d5 100644
--- a/arch/sh/lib/libgcc.h
+++ b/arch/sh/lib/libgcc.h
@@ -17,8 +17,7 @@ struct DWstruct {
 #error I feel sick.
 #endif
 
-typedef union
-{
+typedef union {
 	struct DWstruct s;
 	long long ll;
 } DWunion;
-- 
1.7.0.90.g251a4

