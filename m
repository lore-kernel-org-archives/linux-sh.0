From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 28 Sep 2012 11:05:27 +0000
Subject: [PATCH 15/14] OF:  define of_*_cmp() macros also if CONFIG_OF isn't set
Message-Id: <Pine.LNX.4.64.1209281302390.5428@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1348754853-28619-1-git-send-email-g.liakhovetski@gmx.de>
 <1348754853-28619-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1348754853-28619-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, Sylwester Nawrocki <sylvester.nawrocki@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Stephen Warren <swarren@wwwdotorg.org>, Arnd Bergmann <arnd@arndb.de>, Grant Likely <grant.likely@secretlab.ca>

of_*_cmp() macros do not depend on any OF functions and can be defined also
if CONFIG_OF isn't set. Also include linux/string.h, required by those
macros.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

These definitions are also required for "# CONFIG_OF is not set" builds.

 include/linux/of.h |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 3636fae..ad2e79b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -85,6 +85,14 @@ static inline struct device_node *of_node_get(struct device_node *node)
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
 
+/* Default string compare functions, Allow arch asm/prom.h to override */
+#if !defined(of_compat_cmp)
+#include <linux/string.h>
+#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
+#endif
+
 #ifdef CONFIG_OF
 
 /* Pointer for first entry in chain of all nodes. */
@@ -143,13 +151,6 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
 #endif
 
-/* Default string compare functions, Allow arch asm/prom.h to override */
-#if !defined(of_compat_cmp)
-#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
-#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
-#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
-#endif
-
 /* flag descriptions */
 #define OF_DYNAMIC	1 /* node and properties were allocated via kmalloc */
 #define OF_DETACHED	2 /* node has been detached from the device tree */
-- 
1.7.2.5

