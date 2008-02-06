From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Feb 2008 15:02:50 +0000
Subject: [PATCH] sh: break out unaligned sign extension code
Message-Id: <20080206150250.27073.50160.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Break out the sign extension code since it's used in multiple places.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/traps_32.c |   68 +++++++++++++++------------------------------
 1 file changed, 23 insertions(+), 45 deletions(-)

--- 0001/arch/sh/kernel/traps_32.c
+++ work/arch/sh/kernel/traps_32.c	2008-02-05 14:18:19.000000000 +0900
@@ -147,6 +147,21 @@ static int die_if_no_fixup(const char * 
 	return -EFAULT;
 }
 
+static inline void sign_extend(unsigned int count, unsigned char *dst)
+{
+#ifdef __LITTLE_ENDIAN__
+	if ((count = 2) && dst[1] & 0x80) {
+		dst[2] = 0xff;
+		dst[3] = 0xff;
+	}
+#else
+	if ((count = 2) && dst[2] & 0x80) {
+		dst[0] = 0xff;
+		dst[1] = 0xff;
+	}
+#endif
+}
+
 /*
  * handle an instruction that does an unaligned memory access by emulating the
  * desired behaviour
@@ -178,25 +193,13 @@ static int handle_unaligned_ins(u16 inst
 			dst = (unsigned char*) rn;
 			*(unsigned long*)dst = 0;
 
-#ifdef __LITTLE_ENDIAN__
-			if (copy_from_user(dst, src, count))
-				goto fetch_fault;
-
-			if ((count = 2) && dst[1] & 0x80) {
-				dst[2] = 0xff;
-				dst[3] = 0xff;
-			}
-#else
+#if !defined(__LITTLE_ENDIAN__)
 			dst += 4-count;
-
-			if (__copy_user(dst, src, count))
+#endif
+			if (copy_from_user(dst, src, count))
 				goto fetch_fault;
 
-			if ((count = 2) && dst[2] & 0x80) {
-				dst[0] = 0xff;
-				dst[1] = 0xff;
-			}
-#endif
+			sign_extend(count, dst);
 		} else {
 			/* to memory */
 			src = (unsigned char*) rm;
@@ -253,25 +256,12 @@ static int handle_unaligned_ins(u16 inst
 		dst = (unsigned char*) rn;
 		*(unsigned long*)dst = 0;
 
-#ifdef __LITTLE_ENDIAN__
-		if (copy_from_user(dst, src, count))
-			goto fetch_fault;
-
-		if ((count = 2) && dst[1] & 0x80) {
-			dst[2] = 0xff;
-			dst[3] = 0xff;
-		}
-#else
+#if !defined(__LITTLE_ENDIAN__)
 		dst += 4-count;
-
+#endif
 		if (copy_from_user(dst, src, count))
 			goto fetch_fault;
-
-		if ((count = 2) && dst[2] & 0x80) {
-			dst[0] = 0xff;
-			dst[1] = 0xff;
-		}
-#endif
+		sign_extend(count, dst);
 		ret = 0;
 		break;
 
@@ -299,21 +289,9 @@ static int handle_unaligned_ins(u16 inst
 #if !defined(__LITTLE_ENDIAN__)
 			dst += 2;
 #endif
-
 			if (copy_from_user(dst, src, 2))
 				goto fetch_fault;
-
-#ifdef __LITTLE_ENDIAN__
-			if (dst[1] & 0x80) {
-				dst[2] = 0xff;
-				dst[3] = 0xff;
-			}
-#else
-			if (dst[2] & 0x80) {
-				dst[0] = 0xff;
-				dst[1] = 0xff;
-			}
-#endif
+			sign_extend(2, dst);
 			ret = 0;
 			break;
 		}
