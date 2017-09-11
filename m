From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 11 Sep 2017 20:07:49 +0000
Subject: [PATCH 1/2] [RESEND] of: provide of_n_{addr,size}_cells wrappers for !CONFIG_OF
Message-Id: <20170911200805.3363318-1-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

The pci-rcar driver is enabled for compile tests, and this has
shown that the driver cannot build without CONFIG_OF,
following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
interrupt mapping when possible":

drivers/pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
drivers/pci/host/pcie-rcar.c:1039:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]
  parser->pna = of_n_addr_cells(node);
  ^
As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
supposed to build fine, which we can achieve if we make the
declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
and provide an empty inline function otherwise, as we do for
a lot of other of interfaces.

This lets us build the rcar_pci driver again without CONFIG_OF
for build testing. All platforms using this driver select OF,
so this doesn't change anything for the users.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Magnus Damm <damm@opensource.se>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Fixes: c25da4778803 ("PCI: rcar: Add Renesas R-Car PCIe driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I originally sent the patch in 2014 when things initially broke
and then forgot about while it was applied in my randconfig patch
stack. I sent it again in 2016 and then in July 2017 without reply.

It's still broken and I think this is the correct fix.
---
 include/linux/of.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index cfc34117fc92..fb700d1e1fab 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -734,6 +734,9 @@ static inline struct device_node *of_get_cpu_node(int cpu,
 	return NULL;
 }
 
+static inline int of_n_addr_cells(struct device_node *np) { return 0; }
+static inline int of_n_size_cells(struct device_node *np) { return 0; }
+
 static inline int of_property_read_u64(const struct device_node *np,
 				       const char *propname, u64 *out_value)
 {
-- 
2.9.0

