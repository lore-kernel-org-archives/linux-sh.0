From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 03 Mar 2009 06:18:01 +0000
Subject: Re: [PATCH] sh-sci: console drainage
Message-Id: <20090303061801.GA30177@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 24, 2009 at 03:57:12PM +0900, Magnus Damm wrote:
> Modify the serial console code to wait for the transmit FIFO,
> make sure all bits have been put on the wire before returning.

On Tue, Feb 24, 2009 at 10:11:03PM +0900, Magnus Damm wrote:
> Add support for single IRQ hardware to the sh-rtc driver.
> 
> This is useful for processors with limited interrupt masking
> support such as sh7750 and sh7780. With this patch in place we
> can add logic to the intc code that merges all RTC vectors into
> a single linux interrupt with proper masking/unmasking support.
> 
> Specify a single IRQ in the platform data to use this new shared
> IRQ feature. Separate Periodic/Carry/Alarm IRQs are still supported.

On Tue, Feb 24, 2009 at 10:23:51PM +0900, Magnus Damm wrote:
> Fix iounmap() of pass-through P4 addresses. Without this patch
> iounmap() on the sh7780 rtc area results in a warning message.

On Tue, Feb 24, 2009 at 10:58:57PM +0900, Magnus Damm wrote:
> Instead of keeping the single vector -> single linux irq mapping
> we extend the intc code to support merging of vectors to a single
> linux irq. This helps processors such as sh7750, sh7780 and sh7785
> which have more vectors than masking ability. With this patch in
> place we can modify the intc tables to use one irq per maskable
> irq source. Please note the following:
> 
>  - If multiple vectors share the same enum then only the
>    first vector will be available as a linux irq.
> 
>  - Drivers may need to be rewritten to get pending irq 
>    source from the hardware block instead of irq number.
> 
> This patch together with the sh7785 specific intc tables solves
> DMA controller irq issues related to buggy interrupt masking.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> Reported-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Please try to keep the flow consistent here. Reported-by should always be
first, while Tested-by and so on tend to follow your Signed-off-by.

On Tue, Feb 24, 2009 at 10:59:04PM +0900, Magnus Damm wrote:
> Update intc tables and platform data to use one linux irq
> per maskable interrupt source instead of keeping the one-to-one
> mapping between vectors and linux irqs.
> 
> This fixes potential irq masking issues for sh775x hardware
> blocks such as SCI/SCIF/RTC/DMAC/TMU2/REF.

On Tue, Feb 24, 2009 at 10:59:12PM +0900, Magnus Damm wrote:
> Update intc tables and platform data to use one linux irq
> per maskable interrupt source instead of keeping the one-to-one
> mapping between vectors and linux irqs.
> 
> This fixes potential irq masking issues for sh7780 hardware
> blocks such as SCIF/RTC/DMAC/PCIC5/MMCIF/FLCTL/GPIO

On Tue, Feb 24, 2009 at 10:59:19PM +0900, Magnus Damm wrote:
> Update intc tables and platform data to use one linux irq
> per maskable interrupt source instead of keeping the one-to-one
> mapping between vectors and linux irqs.
> 
> This fixes potential irq masking issues for sh7785 hardware
> blocks such as SCIF/DMAC/PCIC5/MMCIF/GDTA/FLCTL/GPIO

All applied, thanks.
