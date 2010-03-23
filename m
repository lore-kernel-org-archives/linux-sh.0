From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 04:39:31 +0000
Subject: Re: [PATCH 1/2] sh: Flush ITLB too in PTEAEX's flush_tlb_page()
Message-Id: <20100323043930.GH13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1269201103-28283-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1269201103-28283-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 21, 2010 at 07:51:43PM +0000, Matt Fleming wrote:
> flush_tlb_page() can be used to flush TLB entries that map executable
> pages. Therefore, we need to ensure that the ITLB is also flushed in
> local_flush_tlb_page().

On Sun, Mar 21, 2010 at 07:51:52PM +0000, Matt Fleming wrote:
> Setting the TI in MMUCR causes all the TLB bits in MMUCR to be
> cleared. Unfortunately, the TLB wired bits are also cleared when setting
> the TI bit, causing any wired TLB entries to become unwired.
> 
> Use local_flush_tlb_all() which implements TLB flushing in a safer
> manner by using the memory-mapped TLB registers. As each CPU has its own
> PMB the modifications in pmb_init() only affect the local CPU, so only
> flush the local CPU's TLB.

On Mon, Mar 22, 2010 at 10:09:58PM +0000, Matt Fleming wrote:
> set_pmb_entry() is now only used by a function that is wrapped in #ifdef
> CONFIG_PM, so wrap set_pmb_entry() in CONFIG_PM too.

All applied, thanks.
