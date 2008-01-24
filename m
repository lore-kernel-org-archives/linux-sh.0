From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Jan 2008 09:45:45 +0000
Subject: [PATCH] sh: remove consistent alloc stuff from the machine vector
Message-Id: <20080124094545.25820.12273.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: remove consistent alloc stuff from the machine vector

Now with the voyagergx cruft gone and the dreamcast using declared
coherent memory for pci there are no users of the consistent alloc and
free functions pointers in the machine vector.

So this little patch simply removes these function pointers from the macvec.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 include/asm-sh/machvec.h |    3 ---
 1 file changed, 3 deletions(-)

--- 0001/include/asm-sh/machvec.h
+++ work/include/asm-sh/machvec.h	2008-01-24 17:04:11.000000000 +0900
@@ -56,9 +56,6 @@ struct sh_machine_vector {
 
 	void (*mv_heartbeat)(void);
 
-	void *(*mv_consistent_alloc)(struct device *, size_t, dma_addr_t *, gfp_t);
-	int (*mv_consistent_free)(struct device *, size_t, void *, dma_addr_t);
-
 	void __iomem *(*mv_ioport_map)(unsigned long port, unsigned int size);
 	void (*mv_ioport_unmap)(void __iomem *);
 };
