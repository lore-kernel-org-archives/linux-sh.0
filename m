From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Jun 2019 21:20:07 +0000
Subject: [PATCH 07/15] binfmt_flat: use __be32 for the on-disk format
Message-Id: <20190610212015.9157-8-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

So far binfmt_flat has onl been supported on 32-bit platforms, so the
variable size of the fields didn't matter.  But the upcoming RISC-V
nommu port supports 64-bit CPUs, and we now have a conflict between
the elf2flt creation tool that always uses 32-bit fields and the kernel
that uses (unsigned) long field.  Switch to the userspace view as the
rest of the binfmt_flat format is completely architecture neutral,
and binfmt_flat isn't the right binary format for huge executables to
start with.

While we're at it also ensure these fields are using __be types as
they big endian and are byteswapped when loaded.

Signed-off-by: Christoph Hellwig <hch@lst.de>

wip
---
 include/linux/flat.h | 48 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/flat.h b/include/linux/flat.h
index 21d901ba191b..59e892d5fadb 100644
--- a/include/linux/flat.h
+++ b/include/linux/flat.h
@@ -24,26 +24,26 @@
  */
 
 struct flat_hdr {
-	char magic[4];
-	unsigned long rev;          /* version (as above) */
-	unsigned long entry;        /* Offset of first executable instruction
-	                               with text segment from beginning of file */
-	unsigned long data_start;   /* Offset of data segment from beginning of
-	                               file */
-	unsigned long data_end;     /* Offset of end of data segment
-	                               from beginning of file */
-	unsigned long bss_end;      /* Offset of end of bss segment from beginning
-	                               of file */
+	char	magic[4];
+	__be32	rev;          /* version (as above) */
+	__be32	entry;        /* Offset of first executable instruction
+				 with text segment from beginning of file */
+	__be32	data_start;   /* Offset of data segment from beginning of
+				 file */
+	__be32	data_end;     /* Offset of end of data segment from beginning
+				 of file */
+	__be32	bss_end;      /* Offset of end of bss segment from beginning
+				 of file */
 
 	/* (It is assumed that data_end through bss_end forms the bss segment.) */
 
-	unsigned long stack_size;   /* Size of stack, in bytes */
-	unsigned long reloc_start;  /* Offset of relocation records from
-	                               beginning of file */
-	unsigned long reloc_count;  /* Number of relocation records */
-	unsigned long flags;
-	unsigned long build_date;   /* When the program/library was built */
-	unsigned long filler[5];    /* Reservered, set to zero */
+	__be32	stack_size;   /* Size of stack, in bytes */
+	__be32	reloc_start;  /* Offset of relocation records from beginning of
+				 file */
+	__be32	reloc_count;  /* Number of relocation records */
+	__be32	flags;
+	__be32	build_date;   /* When the program/library was built */
+	__u32	filler[5];    /* Reservered, set to zero */
 };
 
 #define FLAT_FLAG_RAM    0x0001 /* load program entirely into RAM */
@@ -67,19 +67,19 @@ struct flat_hdr {
 #define OLD_FLAT_RELOC_TYPE_BSS		2
 
 typedef union {
-	unsigned long	value;
+	u32		value;
 	struct {
 # if defined(mc68000) && !defined(CONFIG_COLDFIRE)
-		signed long offset : 30;
-		unsigned long type : 2;
+		s32	offset : 30;
+		u32	type : 2;
 #   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
 # elif defined(__BIG_ENDIAN_BITFIELD)
-		unsigned long type : 2;
-		signed long offset : 30;
+		u32	type : 2;
+		s32	offset : 30;
 #   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
 # elif defined(__LITTLE_ENDIAN_BITFIELD)
-		signed long offset : 30;
-		unsigned long type : 2;
+		s32	offset : 30;
+		u32	type : 2;
 #   	define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
 # else
 #   	error "Unknown bitfield order for flat files."
-- 
2.20.1
