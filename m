From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Jun 2019 21:20:14 +0000
Subject: [PATCH 14/15] binfmt_flat: don't offset the data start
Message-Id: <20190610212015.9157-15-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Ever since the initial commit of the binfmt_flat shared library
support back in the bitkeeper days we've offset the actual in-memory
.data start by one field per possible shared library, or 1 in case
shared library support isn't enabled.  I can't find anything in the
loader that actually makes use of it, nor was it present before
shared library support it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/binfmt_flat.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 2c7f32d5435f..e1ccc9f14150 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -572,7 +572,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			goto err;
 		}
 
-		len = data_len + extra + MAX_SHARED_LIBS * sizeof(unsigned long);
+		len = data_len + extra;
 		len = PAGE_ALIGN(len);
 		realdatastart = vm_mmap(NULL, 0, len,
 			PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, 0);
@@ -586,9 +586,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 			vm_munmap(textpos, text_len);
 			goto err;
 		}
-		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(unsigned long),
-				FLAT_DATA_ALIGN);
+		datapos = ALIGN(realdatastart, FLAT_DATA_ALIGN);
 
 		pr_debug("Allocated data+bss+stack (%u bytes): %lx\n",
 			 data_len + bss_len + stack_len, datapos);
@@ -618,7 +616,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		memp_size = len;
 	} else {
 
-		len = text_len + data_len + extra + MAX_SHARED_LIBS * sizeof(u32);
+		len = text_len + data_len + extra;
 		len = PAGE_ALIGN(len);
 		textpos = vm_mmap(NULL, 0, len,
 			PROT_READ | PROT_EXEC | PROT_WRITE, MAP_PRIVATE, 0);
@@ -633,9 +631,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		}
 
 		realdatastart = textpos + ntohl(hdr->data_start);
-		datapos = ALIGN(realdatastart +
-				MAX_SHARED_LIBS * sizeof(u32),
-				FLAT_DATA_ALIGN);
+		datapos = ALIGN(realdatastart, FLAT_DATA_ALIGN);
 
 		reloc = (__be32 __user *)
 			(datapos + (ntohl(hdr->reloc_start) - text_len));
@@ -652,8 +648,9 @@ static int load_flat_file(struct linux_binprm *bprm,
 					 (text_len + full_data
 						  - sizeof(struct flat_hdr)),
 					 0);
-			memmove((void *) datapos, (void *) realdatastart,
-					full_data);
+			if (datapos != realdatastart)
+				memmove((void *)datapos, (void *)realdatastart,
+						full_data);
 #else
 			/*
 			 * This is used on MMU systems mainly for testing.
@@ -709,8 +706,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		if (IS_ERR_VALUE(result)) {
 			ret = result;
 			pr_err("Unable to read code+data+bss, errno %d\n", ret);
-			vm_munmap(textpos, text_len + data_len + extra +
-				MAX_SHARED_LIBS * sizeof(u32));
+			vm_munmap(textpos, text_len + data_len + extra);
 			goto err;
 		}
 	}
-- 
2.20.1
