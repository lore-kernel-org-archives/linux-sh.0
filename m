From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 02 Apr 2014 16:54:49 +0000
Subject: [patch] sh: missing break statement
Message-Id: <20140402165449.GA10002@mwanda>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH_BREAKPOINT_READ doesn't work because of the missing break in this
switch statement.

Fixes: 09a072947791 ('sh: hw-breakpoints: Add preliminary support for SH-4A UBC.')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index f9173766..42d30ac 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -160,6 +160,7 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	switch (sh_type) {
 	case SH_BREAKPOINT_READ:
 		*gen_type = HW_BREAKPOINT_R;
+		break;
 	case SH_BREAKPOINT_WRITE:
 		*gen_type = HW_BREAKPOINT_W;
 		break;
