From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Jun 2019 21:20:13 +0000
Subject: [PATCH 13/15] binfmt_flat: move the MAX_SHARED_LIBS definition to binfmt_flat.c
Message-Id: <20190610212015.9157-14-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

MAX_SHARED_LIBS is an implementation detail of the kernel loader,
and should be kept away from the file format definition.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_flat.c     | 6 ++++++
 include/linux/flat.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 114ea225c5a5..2c7f32d5435f 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -68,6 +68,12 @@
 #define RELOC_FAILED 0xff00ff01		/* Relocation incorrect somewhere */
 #define UNLOADED_LIB 0x7ff000ff		/* Placeholder for unused library */
 
+#ifdef CONFIG_BINFMT_SHARED_FLAT
+#define	MAX_SHARED_LIBS			(4)
+#else
+#define	MAX_SHARED_LIBS			(1)
+#endif
+
 struct lib_info {
 	struct {
 		unsigned long start_code;		/* Start of text segment */
diff --git a/include/linux/flat.h b/include/linux/flat.h
index 59e892d5fadb..a2232f1bd41b 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -12,12 +12,6 @@
 
 #define	FLAT_VERSION			0x00000004L
 
-#ifdef CONFIG_BINFMT_SHARED_FLAT
-#define	MAX_SHARED_LIBS			(4)
-#else
-#define	MAX_SHARED_LIBS			(1)
-#endif
-
 /*
  * To make everything easier to port and manage cross platform
  * development,  all fields are in network byte order.
-- 
2.20.1
