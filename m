From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 08 Jan 2008 07:59:20 +0000
Subject: About invalidate cache of SH4
Message-Id: <47832D9E.1010201@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Paul,

When start or size of __flush_invalidate_region() is not cache
alignment, enlarge the range to match it. However, the data is
lost if there are the data which should write-back in there.

For example, struct scsi_cmnd has sense_buffer[]. sense_buffer
is not cache alignment. When there is invalidated sense_buffer,
struct request *request of struct scsi_cmnd may be invalidated.
Connection of the USB memory sometimes fails and cannnot mount
USB-CDROM(oops occured) for this processing.

I made a patch, but this implementation may not be good...

Thanks,
Yoshihiro Shimoda

---
diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index 43d7ff6..cc1751d 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -164,15 +164,37 @@ void __flush_invalidate_region(void *start, int size)
 {
 	unsigned long v;
 	unsigned long begin, end;
+	int no_align = 0;

 	begin = (unsigned long)start & ~(L1_CACHE_BYTES-1);
 	end = ((unsigned long)start + size + L1_CACHE_BYTES-1)
 		& ~(L1_CACHE_BYTES-1);
+
+	if ((unsigned long)start & (L1_CACHE_BYTES - 1) ||
+	    size & (L1_CACHE_BYTES - 1)) {
+		if (size <= (L1_CACHE_BYTES << 1)) {
+			__flush_purge_region(start, size);
+			return;
+		} else {
+			no_align = 1;
+			begin += L1_CACHE_BYTES;
+			end -= L1_CACHE_BYTES;
+		}
+	}
+
+	if (no_align)
+		__flush_purge_region((void *)(begin - L1_CACHE_BYTES),
+				     L1_CACHE_BYTES);
+
 	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
 		asm volatile("ocbi	%0"
 			     : /* no output */
 			     : "m" (__m(v)));
 	}
+
+	if (no_align)
+		__flush_purge_region((void *)(end + L1_CACHE_BYTES),
+				     L1_CACHE_BYTES);
 }

 /*
