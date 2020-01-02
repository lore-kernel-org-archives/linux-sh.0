From: Chen Zhou <chenzhou10@huawei.com>
Date: Thu, 02 Jan 2020 01:54:30 +0000
Subject: [PATCH next] sh: remove call to memset after dma_alloc_coherent
Message-Id: <20200102015430.140729-1-chenzhou10@huawei.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, chenzhou10@huawei.com

Function dma_alloc_coherent use in buf already zeroes out memory,
so memset is not needed.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/sh/mm/consistent.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 3169a34..0de206c 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -57,8 +57,6 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
2.7.4
