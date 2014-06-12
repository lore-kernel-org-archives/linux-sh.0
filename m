From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Jun 2014 08:42:22 +0000
Subject: [PATCH 1/3] ARM: shmobile: rcar-gen2: Update for of_get_flat_dt_prop() update
Message-Id: <1402562544-4527-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1402562544-4527-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1402562544-4527-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org

Commit 9d0c4dfedd96ee54fc075b16d02f82499c8cc3a6 ("of/fdt: update
of_get_flat_dt_prop in prep for libfdt") changed the function prototypes
of of_get_flat_dt_prop():
  - The return type was made const,
  - The last parameter was changed from "unsigned long *" to "int *".
and dt_mem_next_cell():
  - The second parameter was made const.

This causes the following compiler warnings:

arch/arm/mach-shmobile/setup-rcar-gen2.c: In function 'rcar_gen2_scan_mem':
arch/arm/mach-shmobile/setup-rcar-gen2.c:125:15: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
arch/arm/mach-shmobile/setup-rcar-gen2.c:142:2: warning: passing argument 3 of 'of_get_flat_dt_prop' from incompatible pointer type [enabled by default]
include/linux/of_fdt.h:53:20: note: expected 'int *' but argument is of type 'long unsigned int *'
arch/arm/mach-shmobile/setup-rcar-gen2.c:142:6: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
arch/arm/mach-shmobile/setup-rcar-gen2.c:144:3: warning: passing argument 3 of 'of_get_flat_dt_prop' from incompatible pointer type [enabled by default]
include/linux/of_fdt.h:53:20: note: expected 'int *' but argument is of type 'long unsigned int *'
arch/arm/mach-shmobile/setup-rcar-gen2.c:144:7: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]
arch/arm/mach-shmobile/setup-rcar-gen2.c:152:3: warning: passing argument 2 of 'dt_mem_next_cell' from incompatible pointer type [enabled by default]
include/linux/of_fdt.h:69:12: note: expected 'const __be32 **' but argument is of type '__be32 **'
arch/arm/mach-shmobile/setup-rcar-gen2.c:153:3: warning: passing argument 2 of 'dt_mem_next_cell' from incompatible pointer type [enabled by default]
include/linux/of_fdt.h:69:12: note: expected 'const __be32 **' but argument is of type '__be32 **'

Update the variable types in rcar_gen2_scan_mem() to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
This depends on commit 9d0c4dfedd96ee54fc075b16d02f82499c8cc3a6 ("of/fdt:
update of_get_flat_dt_prop in prep for libfdt") in Linus' tree, and
commit ae8bf91c80b0145a54a492851aa7e23cf8054dc0 ("ARM: shmobile: Add shared
R-Car Gen2 CMA reservation code") in Simon's tree
(renesas-devel-v3.15-20140610 and later).

 arch/arm/mach-shmobile/setup-rcar-gen2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 8fecda04a145..1c09789393cd 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -122,9 +122,9 @@ struct memory_reserve_config {
 static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
 				     int depth, void *data)
 {
-	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	__be32 *reg, *endp;
-	unsigned long l;
+	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	const __be32 *reg, *endp;
+	int l;
 	struct memory_reserve_config *mrc = data;
 	u64 lpae_start = (u64)1 << 32;
 
-- 
1.9.1

