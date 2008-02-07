From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Feb 2008 11:42:07 +0000
Subject: Re: [PATCH] sh: make copy_to/from_user() static inline
Message-Id: <20080207114207.GA16769@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207105052.9553.69636.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080207105052.9553.69636.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 07, 2008 at 07:50:52PM +0900, Magnus Damm wrote:
> This patch changes copy_from_user() and copy_to_user() from macros
> into static inline functions. This way we can use them as function
> pointers. Also unify the 64 bit and 32 bit versions.

On Thu, Feb 07, 2008 at 07:58:46PM +0900, Magnus Damm wrote:
> This patch adds byte support to the sign extension code. Unaligned access
> traps should never be generated on 8-bit io operations, but we will use this
> code for trapped io and we do need byte support there.

On Thu, Feb 07, 2008 at 08:04:12PM +0900, Magnus Damm wrote:
> This patch converts the unaligned access handling code to use opcode_t
> instead of u16. While at it, enable unaligned access handling for sh2a.

On Thu, Feb 07, 2008 at 08:08:46PM +0900, Magnus Damm wrote:
> Update the defconfigs for r2d-plus and r2d-1 since we now have new drivers
> for sm501 usb, spi-over-sci and epson r9701 rtc in mainline.

These I've applied, thans. I'll have a look at the trapped I/O V2 bits in
the morning.
