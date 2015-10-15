From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 15 Oct 2015 00:33:54 +0000
Subject: [PATCH 6/6] ARM: shmobile: R-Mobile: add missing of_node_put
Message-Id: <1fd377b3fc1e071702e27b2f828e3abd8b31c74d.1444868660.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444868660.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444868660.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

for_each_child_of_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
(
   return child;
|
+  of_node_put(child);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/pm-rmobile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index a5b96b990aea..424155b0cfe9 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -342,8 +342,10 @@ static int __init rmobile_add_pm_domains(void __iomem *base,
 		}
 
 		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
-		if (!pd)
+		if (!pd) {
+			of_node_put(np);
 			return -ENOMEM;
+		}
 
 		pd->genpd.name = np->name;
 		pd->base = base;
-- 
2.1.4

