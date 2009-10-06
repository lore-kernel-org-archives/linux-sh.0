From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:34 +0000
Subject: [PATCH 14/14] sh: Don't allocate smaller sized mappings on every iteration
Message-Id: <09b3f0f688064534368f251eac86dc5b0afbc7a1.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Currently, we've got the less than ideal situation where if we need to
allocate a 256MB mapping we'll allocate four entries like so,

	 entry 1: 128MB
	 entry 2:  64MB
	 entry 3:  16MB
	 entry 4:  16MB

This is because as we execute the loop in pmb_remap() we will
progressively try mapping the remaining address space with smaller and
smaller sizes. This isn't good because the size we use on one iteration
may be the perfect size to use on the next iteration, for instance when
the initial size is divisible by one of the PMB mapping sizes.

With this patch, we now only need two entries in the PMB to map 256MB of
address space,

	  entry 1: 128MB
	  entry 2: 128MB

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/mm/pmb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index f821c2e..280f6a1 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -214,6 +214,13 @@ again:
 			pmbp->link = pmbe;
 
 		pmbp = pmbe;
+
+		/*
+		 * Instead of trying smaller sizes on every iteration
+		 * (even if we succeed in allocating space), try using
+		 * pmb_sizes[i].size again.
+		 */
+		i--;
 	}
 
 	if (size >= 0x1000000)
-- 
1.6.3.3

