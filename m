From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 08 Nov 2013 09:44:01 +0000
Subject: [patch] sh: off by one in setup_bootmem_node()
Message-Id: <20131108094401.GB27977@elgon.mountain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If "nid = MAX_NUMNODES" then we would write one space past the end of
the array later on in the function.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index 3d85225..bce52ba 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -31,7 +31,7 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 	unsigned long bootmem_paddr;
 
 	/* Don't allow bogus node assignment */
-	BUG_ON(nid > MAX_NUMNODES || nid <= 0);
+	BUG_ON(nid >= MAX_NUMNODES || nid <= 0);
 
 	start_pfn = start >> PAGE_SHIFT;
 	end_pfn = end >> PAGE_SHIFT;
