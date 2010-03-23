From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 08:55:01 +0000
Subject: Re: [PATCH] sh: add INTC out of memory error handling
Message-Id: <20100323085501.GE30655@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100310093101.5422.38371.sendpatchset@t400s>
In-Reply-To: <20100310093101.5422.38371.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 10, 2010 at 06:31:01PM +0900, Magnus Damm wrote:
> Extend the INTC code to warn and return an error code
> in the case of memory allocation failure.

On Wed, Mar 10, 2010 at 06:38:55PM +0900, Magnus Damm wrote:
> Extend the INTC code with ioremap() support V2.
> 
> Support INTC controllers that are not accessible through
> a 1:1 virt:phys window. Needed by SH-Mobile ARM INTCS.
> 
> The INTC code behaves as usual if the io window resource
> is omitted. The slow phys->virt lookup only happens during
> setup. The fast path code operates on virtual addresses.

Both applied to the sh/intc-extension topic branch, thanks.
