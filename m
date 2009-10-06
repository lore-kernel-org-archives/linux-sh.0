From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:27 +0000
Subject: [PATCH 07/14] sh: Try PMB mapping based on physical address, not mapping size
Message-Id: <014aa11fe1891ca085d72b8b6fb56703b7637a8b.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We should favour PMB mappings when the physical address cannot be
reached with 29-bits.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/ioremap_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/mm/ioremap_32.c b/arch/sh/mm/ioremap_32.c
index c325061..a86eaa9 100644
--- a/arch/sh/mm/ioremap_32.c
+++ b/arch/sh/mm/ioremap_32.c
@@ -83,7 +83,7 @@ void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
 	 *
 	 * PMB entries are all pre-faulted.
 	 */
-	if (unlikely(size >= 0x1000000)) {
+	if (unlikely(phys_addr >= P1SEG)) {
 		unsigned long mapped = pmb_remap(addr, phys_addr, size, flags);
 
 		if (likely(mapped)) {
-- 
1.6.3.3

