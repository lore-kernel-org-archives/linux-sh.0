From: Christoph Hellwig <hch@lst.de>
Date: Thu, 13 Jun 2019 07:08:53 +0000
Subject: [PATCH 07/17] binfmt_flat: remove the unused OLD_FLAT_FLAG_RAM definition
Message-Id: <20190613070903.17214-8-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190613070903.17214-1-hch@lst.de>
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/flat.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/flat.h b/include/linux/flat.h
index 21d901ba191b..2b7cda6e9c1b 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -72,15 +72,12 @@ typedef union {
 # if defined(mc68000) && !defined(CONFIG_COLDFIRE)
 		signed long offset : 30;
 		unsigned long type : 2;
-#   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
 # elif defined(__BIG_ENDIAN_BITFIELD)
 		unsigned long type : 2;
 		signed long offset : 30;
-#   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
 # elif defined(__LITTLE_ENDIAN_BITFIELD)
 		signed long offset : 30;
 		unsigned long type : 2;
-#   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
 # else
 #   	error "Unknown bitfield order for flat files."
 # endif
-- 
2.20.1
