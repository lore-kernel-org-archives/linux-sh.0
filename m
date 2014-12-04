From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 04 Dec 2014 11:01:10 +0000
Subject: [patch] sh: off by one BUG_ON() in setup_bootmem_node()
Message-Id: <20141204110110.GD22643@mwanda>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <CAMuHMdVxCUYkaC5wzHi-o6knD6ugFudTdh3PJz5JCwv-std3GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Mundt <lethal@linux-sh.org>

This off by one bug is harmless but it upsets the static checkers and
the code is obvious so it doesn't hurt to fix it.  The Smatch warning
is:

	arch/sh/mm/numa.c:47 setup_bootmem_node()
	error: buffer overflow 'node_data' 1024 <= 1024

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
