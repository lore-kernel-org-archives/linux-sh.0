From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Apr 2015 05:17:37 +0000
Subject: [PATCH 3/3] drivers: sh: Remove test for now unsupported sh7372
Message-Id: <00170528f0486c08a18475af7fefa0a7679e042d.1430370969.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1430370969.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1430370969.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pm_runtime.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 89b7785de1fc..fe8875f0d7be 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -91,8 +91,7 @@ static int __init sh_pm_runtime_init(void)
 		    !of_machine_is_compatible("renesas,r8a7791") &&
 		    !of_machine_is_compatible("renesas,r8a7792") &&
 		    !of_machine_is_compatible("renesas,r8a7793") &&
-		    !of_machine_is_compatible("renesas,r8a7794") &&
-		    !of_machine_is_compatible("renesas,sh7372"))
+		    !of_machine_is_compatible("renesas,r8a7794"))
 			return 0;
 	}
 
-- 
2.1.4

