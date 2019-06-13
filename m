From: Christoph Hellwig <hch@lst.de>
Date: Thu, 13 Jun 2019 07:09:00 +0000
Subject: [PATCH 14/17] binfmt_flat: remove the persistent argument from flat_get_addr_from_rp
Message-Id: <20190613070903.17214-15-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190613070903.17214-1-hch@lst.de>
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

The argument is never used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/c6x/include/asm/flat.h        | 2 +-
 arch/h8300/include/asm/flat.h      | 2 +-
 arch/microblaze/include/asm/flat.h | 2 +-
 arch/sh/include/asm/flat.h         | 2 +-
 arch/xtensa/include/asm/flat.h     | 2 +-
 fs/binfmt_flat.c                   | 4 +---
 include/asm-generic/flat.h         | 2 +-
 7 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
index 2d57a9204d21..9e6544b51386 100644
--- a/arch/c6x/include/asm/flat.h
+++ b/arch/c6x/include/asm/flat.h
@@ -5,7 +5,7 @@
 #include <asm/unaligned.h>
 
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
-					u32 *addr, u32 *persistent)
+					u32 *addr)
 {
 	*addr = get_unaligned((__force u32 *)rp);
 	return 0;
diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
index 4683146f0e9e..78070f924177 100644
--- a/arch/h8300/include/asm/flat.h
+++ b/arch/h8300/include/asm/flat.h
@@ -17,7 +17,7 @@
 
 #define	flat_get_relocate_addr(rel)		(rel & ~0x00000001)
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
-					u32 *addr, u32 *persistent)
+					u32 *addr)
 {
 	u32 val = get_unaligned((__force u32 *)rp);
 	if (!(flags & FLAT_FLAG_GOTPIC))
diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/include/asm/flat.h
index 9e3d8e01d294..1ab86770eaee 100644
--- a/arch/microblaze/include/asm/flat.h
+++ b/arch/microblaze/include/asm/flat.h
@@ -28,7 +28,7 @@
  */
 
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
-					u32 *addr, u32 *persistent)
+					u32 *addr)
 {
 	u32 *p = (__force u32 *)rp;
 
diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
index 1002343dd84a..fee4f25555cb 100644
--- a/arch/sh/include/asm/flat.h
+++ b/arch/sh/include/asm/flat.h
@@ -12,7 +12,7 @@
 #include <asm/unaligned.h>
 
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
-					u32 *addr, u32 *persistent)
+					u32 *addr)
 {
 	*addr = get_unaligned((__force u32 *)rp);
 	return 0;
diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
index 3d357371b28b..ed5870c779f9 100644
--- a/arch/xtensa/include/asm/flat.h
+++ b/arch/xtensa/include/asm/flat.h
@@ -5,7 +5,7 @@
 #include <asm/unaligned.h>
 
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
-					u32 *addr, u32 *persistent)
+					u32 *addr)
 {
 	*addr = get_unaligned((__force u32 *)rp);
 	return 0;
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 1e88f4e62e65..0ca65d51bb01 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -795,7 +795,6 @@ static int load_flat_file(struct linux_binprm *bprm,
 	 * __start to address 4 so that is okay).
 	 */
 	if (rev > OLD_FLAT_VERSION) {
-		u32 __maybe_unused persistent = 0;
 		for (i = 0; i < relocs; i++) {
 			u32 addr, relval;
 			__be32 tmp;
@@ -816,8 +815,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			}
 
 			/* Get the pointer's value.  */
-			ret = flat_get_addr_from_rp(rp, relval, flags,
-							&addr, &persistent);
+			ret = flat_get_addr_from_rp(rp, relval, flags, &addr);
 			if (unlikely(ret))
 				goto err;
 
diff --git a/include/asm-generic/flat.h b/include/asm-generic/flat.h
index fcd2b45c0735..1928a3596938 100644
--- a/include/asm-generic/flat.h
+++ b/include/asm-generic/flat.h
@@ -5,7 +5,7 @@
 #include <linux/uaccess.h>
 
 static inline int flat_get_addr_from_rp(u32 __user *rp, u32 relval, u32 flags,
-		u32 *addr, u32 *persistent)
+		u32 *addr)
 {
 #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 	return copy_from_user(addr, rp, 4) ? -EFAULT : 0;
-- 
2.20.1
