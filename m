From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Jun 2012 12:34:49 +0000
Subject: Re: Tell me why 8 continuos ocbp ins's exist in sh4_flush_purge_region().
Message-Id: <20120627123448.GJ24033@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20120627115255.4576ee43bd7b6c4ecf34de73@kanno.co.jp>
In-Reply-To: <20120627115255.4576ee43bd7b6c4ecf34de73@kanno.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 27, 2012 at 11:52:55AM +0900, MASAO TAKAHASHI wrote:
> Hi everybody.
> 
> Please tell me why 8 continuos "ocbp" instructions exist
>  in sh4_flush_purge_region() as follows.
>   --------------------------------------------------
> 	while (cnt >= 8) {
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		__ocbp(v); v += L1_CACHE_BYTES;
> 		cnt -= 8;
> 	}
>  -----------------------------------------------------
> 
> The previous version was like this.
>  ------------------------------------------------------- 
> 	for (v = begin; v < end; v+=L1_CACHE_BYTES) {
> 		asm volatile("ocbp	%0"
> 			     : /* no output */
> 			     : "m" (__m(v)));
> 	}
>  --------------------------------------------------------
> 
We unroll the loop for better performance. The same applies for the wback
and invalidate cases, too. If you're passing in a small size then the >8 case is surpassed and you go to line-at-a-time obcp as before.
