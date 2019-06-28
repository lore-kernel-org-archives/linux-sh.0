From: Christoph Hellwig <hch@lst.de>
Date: Fri, 28 Jun 2019 06:25:24 +0000
Subject: [PATCH] sh: clkfwk: don't pass void pointers to ioread*
Message-Id: <20190628062524.5436-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Passing pointers with a const attr=D1=96bute to the ioread* functions
causes a lot of compiler warnings, so remove the extra attributes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/sh/clk/cpg.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index eeb028b9cdb3..4f3d99d37809 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
 		iowrite32(value, clk->mapped_reg);
 }
=20
-static unsigned int r8(const void __iomem *addr)
+static unsigned int r8(void __iomem *addr)
 {
 	return ioread8(addr);
 }
=20
-static unsigned int r16(const void __iomem *addr)
+static unsigned int r16(void __iomem *addr)
 {
 	return ioread16(addr);
 }
=20
-static unsigned int r32(const void __iomem *addr)
+static unsigned int r32(void __iomem *addr)
 {
 	return ioread32(addr);
 }
@@ -55,7 +55,7 @@ static int sh_clk_mstp_enable(struct clk *clk)
 {
 	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
 	if (clk->status_reg) {
-		unsigned int (*read)(const void __iomem *addr);
+		unsigned int (*read)(void __iomem *addr);
 		int i;
 		void __iomem *mapped_status =3D (phys_addr_t)clk->status_reg -
 			(phys_addr_t)clk->enable_reg + clk->mapped_reg;
--=20
2.20.1
