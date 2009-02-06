From: Guennadi Liakhovetski <lg@denx.de>
Date: Fri, 06 Feb 2009 12:22:33 +0000
Subject: [PATCH] fix broken size test in bitmap_find_free_region()
Message-Id: <Pine.LNX.4.64.0902061313260.6241@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <8b67d60901201348r6a59928dw3fcf8c9c823d5c68@mail.gmail.com>
 <1232488507.6794.8.camel@localhost.localdomain> <20090121033951.GB14094@linux-sh.org>
 <20090121081118.GA14537@linux-sh.org> <20090127134831.3dd04182.akpm@linux-foundation.org>
 <20090127225458.GA8756@linux-sh.org> <Pine.LNX.4.64.0901280913090.4926@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0901280913090.4926@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, adrian@newgolddream.dyndns.info, lkmladrian@gmail.com, linux-sh@vger.kernel.org, penberg@cs.helsinki.fi, dbaryshkov@gmail.com, penguin-kernel@i-love.sakura.ne.jp, hannes@cmpxchg.org

This loop and test in bitmap_find_free_region()

	for (pos = 0; pos < bits; pos += (1 << order))
		if (__reg_op(bitmap, pos, order, REG_OP_ISFREE))
			break;
	if (pos = bits)
		return -ENOMEM;

can only return an error (-ENOMEM) if bits is a multiple of (1 << order), 
which is, for instance, true, if bits is (also) a power of 2. This 
is not necessarily the case with dma_alloc_from_coherent(). A failure to 
recognise too large a request leads in dma_alloc_from_coherent() to 
accessing beyond available memory, and to writing beyond the bitmap.

Signed-off-by: Guennadi Liakhovetski <lg@denx.de>
---

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 1338469..d49c37f 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -953,7 +953,7 @@ int bitmap_find_free_region(unsigned long *bitmap, int bits, int order)
 	for (pos = 0; pos < bits; pos += (1 << order))
 		if (__reg_op(bitmap, pos, order, REG_OP_ISFREE))
 			break;
-	if (pos = bits)
+	if (pos + (1 << order) > bits)
 		return -ENOMEM;
 	__reg_op(bitmap, pos, order, REG_OP_ALLOC);
 	return pos;
