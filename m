From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 17 Jul 2013 23:32:01 +0000
Subject: [PATCH 22/22] ARM: shmobile: Remove unused mach/dma.h
Message-Id: <ebd9616f439a8a46b9dca9a272b342f34c5f3614.1374103272.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove mach-shmobile mach/dma.h since it only
seems to be used on non-mach-shmobile platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/dma.h |    1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/dma.h

diff --git a/arch/arm/mach-shmobile/include/mach/dma.h b/arch/arm/mach-shmobile/include/mach/dma.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-shmobile/include/mach/dma.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
-- 
1.7.10.4

