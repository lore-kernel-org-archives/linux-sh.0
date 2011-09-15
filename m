From: Simon Horman <horms@verge.net.au>
Date: Thu, 15 Sep 2011 11:12:59 +0000
Subject: [RFC] sh: Take into account the base of physical memory in virt_to_phys()
Message-Id: <1316085179-4207-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Previously virt_to_phys() assumed that physical memory always started
at address 0. This is not always the case.

Tested on an sh7757lcr (32bit system) whose only System RAM region is
40000000-4effffff

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/sh/kexec-sh.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/kexec/arch/sh/kexec-sh.c b/kexec/arch/sh/kexec-sh.c
index 4b21ee8..b0381bb 100644
--- a/kexec/arch/sh/kexec-sh.c
+++ b/kexec/arch/sh/kexec-sh.c
@@ -188,10 +188,18 @@ void kexec_sh_setup_zero_page(char *zero_page_buf, size_t zero_page_size,
 unsigned long virt_to_phys(unsigned long addr)
 {
 	unsigned long seg = addr & 0xe0000000;
+	unsigned long long start, end;
+	int ret;
+
+	/* Assume there is only one "System RAM" region */
+	ret = parse_iomem_single("System RAM\n", &start, &end);
+	if (ret)
+		die("Could not parse System RAM region in /proc/iomem\n");
+
 	if (seg != 0x80000000 && seg != 0xc0000000)
 		die("Virtual address %p is not in P1 or P2\n", (void *)addr);
 
-	return addr - seg;
+	return addr - seg + start;
 }
 
 /*
-- 
1.7.5.4

