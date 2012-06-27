From: MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
Date: Wed, 27 Jun 2012 02:52:55 +0000
Subject: Tell me why 8 continuos ocbp ins's exist in sh4_flush_purge_region().
Message-Id: <20120627115255.4576ee43bd7b6c4ecf34de73@kanno.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi everybody.

Please tell me why 8 continuos "ocbp" instructions exist
 in sh4_flush_purge_region() as follows.
  --------------------------------------------------
	while (cnt >= 8) {
		__ocbp(v); v += L1_CACHE_BYTES;
		__ocbp(v); v += L1_CACHE_BYTES;
		__ocbp(v); v += L1_CACHE_BYTES;
		__ocbp(v); v += L1_CACHE_BYTES;
		__ocbp(v); v += L1_CACHE_BYTES;
		__ocbp(v); v += L1_CACHE_BYTES;
		__ocbp(v); v += L1_CACHE_BYTES;
		__ocbp(v); v += L1_CACHE_BYTES;
		cnt -= 8;
	}
 -----------------------------------------------------

The previous version was like this.
 ------------------------------------------------------- 
	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
		asm volatile("ocbp	%0"
			     : /* no output */
			     : "m" (__m(v)));
	}
 --------------------------------------------------------



----------------------------------------------

MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
TEL 093-436-2330
