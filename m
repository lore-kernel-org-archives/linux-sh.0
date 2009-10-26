From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 02:02:23 +0000
Subject: Re: [PATCH] sh: Check for return_to_handler when unwinding the stack
Message-Id: <20091026020222.GD6108@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1256410617-16860-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1256410617-16860-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Oct 24, 2009 at 07:56:57PM +0100, Matt Fleming wrote:
> When CONFIG_FUNCTION_GRAPH_TRACER is enabled the function graph tracer
> may patch return addresses on the stack with the address of
> return_to_handler(). This really confuses the DWARF unwinder because it
> will try find the caller of return_to_handler(), not the caller of the
> real return address.
> 
> So teach the DWARF unwinder how to find the real return address whenever
> it encounters return_to_handler().
> 
> This patch does not cope very well when multiple return addresses on the
> stack have been patched. To make it work properly it would require state
> to track how many return_to_handler()'s have been seen so that we'd know
> where to look in current->curr_ret_stack[]. So for now, instead of
> trying to handle this, just moan if more than one return address on the
> stack has been patched.
> 
> Signed-off-by: Matt Fleming <matt@console-pimps.org>

Applied, thanks.
