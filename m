From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 09 Feb 2010 09:27:32 +0000
Subject: Re: [PATCH] sh: extend INTC with struct intc_hw_desc
Message-Id: <20100209092732.GB17722@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100209042446.30785.32661.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100209042446.30785.32661.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 09, 2010 at 01:24:46PM +0900, Magnus Damm wrote:
> This patch updates the INTC code by moving all vectors,
> groups and registers from struct intc_desc to struct
> intc_hw_desc.
> 
> The idea is that INTC tables should go from using the
> macro(s) DECLARE_INTC_DESC..() only to using struct
> intc_desc with name and hw initialized using the macro
> INTC_HW_DESC(). This move makes it easy to initialize
> an extended struct intc_desc in the future.

On Tue, Feb 09, 2010 at 01:29:22PM +0900, Magnus Damm wrote:
> Extend the shared INTC code with force_enable support to
> allow keeping mask bits statically enabled. Needed by
> upcoming INTC SDHI patches that mux together a bunch of
> vectors to a single linux interrupt which is masked by
> a priority register, but needs individual mask bits
> constantly enabled.

These two have been rolled in to the sh/intc-extension topic branch and
folded in to the sh tree. When you have patches ready for the genesis
tree that depend on these make sure you have the dependencies clearly
stated and I'll roll them in there at that point, too.
