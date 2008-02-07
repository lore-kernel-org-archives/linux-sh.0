From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Feb 2008 10:58:46 +0000
Subject: [PATCH] sh: add byte support to the sign extension code
Message-Id: <20080207105846.9562.55554.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds byte support to the sign extension code. Unaligned access
traps should never be generated on 8-bit io operations, but we will use this
code for trapped io and we do need byte support there.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/traps_32.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/traps_32.c
+++ work/arch/sh/kernel/traps_32.c	2008-02-07 15:38:46.000000000 +0900
@@ -150,14 +150,24 @@ static int die_if_no_fixup(const char * 
 static inline void sign_extend(unsigned int count, unsigned char *dst)
 {
 #ifdef __LITTLE_ENDIAN__
+	if ((count = 1) && dst[0] & 0x80) {
+		dst[1] = 0xff;
+		dst[2] = 0xff;
+		dst[3] = 0xff;
+	}
 	if ((count = 2) && dst[1] & 0x80) {
 		dst[2] = 0xff;
 		dst[3] = 0xff;
 	}
 #else
-	if ((count = 2) && dst[2] & 0x80) {
+	if ((count = 1) && dst[3] & 0x80) {
+		dst[2] = 0xff;
+		dst[1] = 0xff;
 		dst[0] = 0xff;
+	}
+	if ((count = 2) && dst[2] & 0x80) {
 		dst[1] = 0xff;
+		dst[0] = 0xff;
 	}
 #endif
 }
