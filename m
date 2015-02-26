From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Thu, 26 Feb 2015 11:35:14 +0000
Subject: [PATCHv3 11/17] sh: expose number of page table levels
Message-Id: <1424950520-90188-12-git-send-email-kirill.shutemov@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424950520-90188-1-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1424950520-90188-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-sh@vger.kernel.org

We would want to use number of page table level to define mm_struct.
Let's expose it as CONFIG_PGTABLE_LEVELS.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: linux-sh@vger.kernel.org
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index eb4ef274ae9b..50057fed819d 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -162,6 +162,10 @@ config NEED_DMA_MAP_STATE
 config NEED_SG_DMA_LENGTH
 	def_bool y
 
+config PGTABLE_LEVELS
+	default 3 if X2TLB
+	default 2
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
2.1.4

