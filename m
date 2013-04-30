From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Apr 2013 07:11:23 +0000
Subject: [PATCH 4/4] OF: modify function stubs to match proper function declarations.
Message-Id: <1367305883-2997-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1367305883-2997-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1367305883-2997-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

of_parse_phandle_with_args() and of_count_phandle_with_args() functions
are declared with their first parameter as const. However, their
respective stubs, used when CONFIG_OF isn't defined, don't have the "const"
modifier. This patch adds it to fix the mismatch.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 include/linux/of.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index 30ae71f..d9dbf73 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -466,7 +466,7 @@ static inline struct device_node *of_parse_phandle(const struct device_node *np,
 	return NULL;
 }
 
-static inline int of_parse_phandle_with_args(struct device_node *np,
+static inline int of_parse_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name,
 					     int index,
@@ -485,7 +485,7 @@ static inline int of_parse_phandle_with_child_args(const struct device_node *np,
 	return -ENOSYS;
 }
 
-static inline int of_count_phandle_with_args(struct device_node *np,
+static inline int of_count_phandle_with_args(const struct device_node *np,
 					     const char *list_name,
 					     const char *cells_name)
 {
-- 
1.7.2.5

