From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 21 Jul 2018 03:28:24 +0000
Subject: [PATCH] arch/h8300: modify ffs(), fls() etc. functions to return int
Message-Id: <1cdcd8e1-b12c-31cb-1188-c062dae3e461@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Building drivers/mtd/nand/raw/nandsim.c on arch/hexagon/ produces a
printk format build warning.  This is due to hexagon's ffs() being
coded as returning long instead of int.

Fix the printk format warning by changing all of hexagon's ffx() and
flx() functions to return int instead of long.  The variables that
they return are already int instead of long.

../drivers/mtd/nand/raw/nandsim.c: In function 'init_nandsim':
../drivers/mtd/nand/raw/nandsim.c:760:2: warning: format '%u' expects argument of type 'unsigned int', but argument 2 has type 'long int' [-Wformat]


There are no ffx() or flx() allmodconfig build errors after making this
change.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/hexagon/include/asm/bitops.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20180717.orig/arch/hexagon/include/asm/bitops.h
+++ linux-next-20180717/arch/hexagon/include/asm/bitops.h
@@ -194,7 +194,7 @@ static inline int __test_bit(int nr, con
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline long ffz(int x)
+static inline int ffz(int x)
 {
 	int r;
 
@@ -211,7 +211,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline long fls(int x)
+static inline int fls(int x)
 {
 	int r;
 
@@ -232,7 +232,7 @@ static inline long fls(int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline long ffs(int x)
+static inline int ffs(int x)
 {
 	int r;
 
@@ -254,7 +254,7 @@ static inline long ffs(int x)
  * bits_per_long assumed to be 32
  * numbering starts at 0 I think (instead of 1 like ffs)
  */
-static inline unsigned long __ffs(unsigned long word)
+static inline int __ffs(unsigned long word)
 {
 	int num;
 
@@ -272,7 +272,7 @@ static inline unsigned long __ffs(unsign
  * Undefined if no set bit exists, so code should check against 0 first.
  * bits_per_long assumed to be 32
  */
-static inline unsigned long __fls(unsigned long word)
+static inline int __fls(unsigned long word)
 {
 	int num;
 


