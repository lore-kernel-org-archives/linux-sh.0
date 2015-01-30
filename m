From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri, 30 Jan 2015 14:43:22 +0000
Subject: [PATCH 13/19] sh: expose number of page table levels
Message-Id: <1422629008-13689-14-git-send-email-kirill.shutemov@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422629008-13689-1-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1422629008-13689-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-sh@vger.kernel.org

We would want to use number of page table level to define mm_struct.
Let's expose it as CONFIG_PGTABLE_LEVELS.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: linux-sh@vger.kernel.org
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

