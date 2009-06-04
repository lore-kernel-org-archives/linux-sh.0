From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 04 Jun 2009 09:44:55 +0000
Subject: [PATCH] sh: 16-bit get_unaligned() sh4a fix
Message-Id: <20090604094455.6479.7665.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch fixes the 16-bit case of the sh4a specific
unaligned access implementation. Without this patch
the 16-bit version of sh4a get_unaligned() results in
a 32-bit read which may read more data than intended
and/or cross page boundaries.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Unbreaks mtd NOR write handling on Migo-R.

 arch/sh/include/asm/unaligned-sh4a.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/arch/sh/include/asm/unaligned-sh4a.h
+++ work/arch/sh/include/asm/unaligned-sh4a.h	2009-06-04 18:36:15.000000000 +0900
@@ -41,9 +41,9 @@ struct __una_u64 { u64 x __attribute__((
 static inline u16 __get_unaligned_cpu16(const u8 *p)
 {
 #ifdef __LITTLE_ENDIAN
-	return __get_unaligned_cpu32(p) & 0xffff;
+	return p[0] | (p[1] << 8);
 #else
-	return __get_unaligned_cpu32(p) >> 16;
+	return (p[0] << 8) | p[1];
 #endif
 }
 
