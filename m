From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 28 Mar 2019 14:37:03 +0000
Subject: [PATCH] perf/arch/sh: add a break statement
Message-Id: <20190328143703.GM32613@kadam>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There was obviously supposed to be break statement here.

Fixes: 09a072947791 ("sh: hw-breakpoints: Add preliminary support for SH-4A UBC.")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 arch/sh/kernel/hw_breakpoint.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index bc96b16288c1..af6a65ac04cf 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -157,6 +157,7 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	switch (sh_type) {
 	case SH_BREAKPOINT_READ:
 		*gen_type = HW_BREAKPOINT_R;
+		break;
 	case SH_BREAKPOINT_WRITE:
 		*gen_type = HW_BREAKPOINT_W;
 		break;
-- 
2.17.1
