From: Christoph Hellwig <hch@lst.de>
Date: Thu, 13 Jun 2019 07:08:54 +0000
Subject: [PATCH 08/17] binfmt_flat: consolidate two version of flat_v2_reloc_t
Message-Id: <20190613070903.17214-9-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190613070903.17214-1-hch@lst.de>
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Two branches of the ifdef maze actually have the same content, so merge
them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/flat.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/flat.h b/include/linux/flat.h
index 2b7cda6e9c1b..19c586b74b99 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -69,15 +69,13 @@ struct flat_hdr {
 typedef union {
 	unsigned long	value;
 	struct {
-# if defined(mc68000) && !defined(CONFIG_COLDFIRE)
+#if defined(__LITTLE_ENDIAN_BITFIELD) || \
+    (defined(mc68000) && !defined(CONFIG_COLDFIRE))
 		signed long offset : 30;
 		unsigned long type : 2;
 # elif defined(__BIG_ENDIAN_BITFIELD)
 		unsigned long type : 2;
 		signed long offset : 30;
-# elif defined(__LITTLE_ENDIAN_BITFIELD)
-		signed long offset : 30;
-		unsigned long type : 2;
 # else
 #   	error "Unknown bitfield order for flat files."
 # endif
-- 
2.20.1
