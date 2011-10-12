From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Oct 2011 22:44:41 +0000
Subject: [PATCH 2/2] sh: On 32bit segments may not be in P2
Message-Id: <1318459481-23527-2-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/sh/kexec-sh.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index a397d08..7710fdf 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -219,13 +219,15 @@ unsigned long virt_to_phys(unsigned long addr)
 {
 	unsigned long seg = addr & 0xe0000000;
 	unsigned long long start = 0;
+	int have_32bit = is_32bit();
 
-	if (seg != 0x80000000 && seg != 0xc0000000)
-		die("Virtual address %p is not in P1 or P2\n", (void *)addr);
+	if (seg != 0x80000000 && (have_32bit || seg != 0xc0000000))
+		die("Virtual address %p is not in P1%s\n", (void *)addr,
+		    have_32bit ? "" : " or P2");
 
 	/* If 32bit addressing is used then the base of system RAM
 	 * is an offset into physical memory. */
-	if (is_32bit()) {
+	if (have_32bit) {
 		unsigned long long end;
 		int ret;
 
-- 
1.7.6.3

