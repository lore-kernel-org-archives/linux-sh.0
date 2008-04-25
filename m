From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 25 Apr 2008 09:06:01 +0000
Subject: Re: [PATCH] sh: update smc91x platform data for MigoR
Message-Id: <20080425090601.GC30569@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080423111359.3386.28006.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080423111359.3386.28006.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 23, 2008 at 08:13:59PM +0900, Magnus Damm wrote:
> Select smc91x bus width and irg flags using platform data for MigoR
> now when the smc91x header file is in place.

On Wed, Apr 23, 2008 at 08:18:04PM +0900, Magnus Damm wrote:
> Select smc91x bus width using platform data for se7722 now when the
> smc91x header file is in place.

On Wed, Apr 23, 2008 at 08:24:52PM +0900, Magnus Damm wrote:
> Fix sh7705 interrupt sources for vectors 0xc80 and 0xca0.

On Wed, Apr 23, 2008 at 08:50:27PM +0900, Magnus Damm wrote:
> Do like everyone else and have a struct resource for kernel bss.

On Wed, Apr 23, 2008 at 08:56:44PM +0900, Magnus Damm wrote:
> Add physical memory resources such as System RAM, Kernel code/data/bss
> and reserved crash dump area to /proc/iomem. Same strategy as on x86.

On Wed, Apr 23, 2008 at 09:00:54PM +0900, Magnus Damm wrote:
> Use sci_out() instead of ctrl_outw() for early printk setup code.

On Wed, Apr 23, 2008 at 09:05:11PM +0900, Magnus Damm wrote:
> Drain by waiting for all characters to be sent, and make sure to
> wait a little bit after setting up the baud rate.

On Wed, Apr 23, 2008 at 09:16:06PM +0900, Magnus Damm wrote:
> Reset the transmitter and receiver when setting up early printk.

On Wed, Apr 23, 2008 at 09:25:29PM +0900, Magnus Damm wrote:
> Improve sh7722 support for SCIF1 and SCIF2 and separate code
> from sh7366 implementation.

On Wed, Apr 23, 2008 at 09:31:14PM +0900, Magnus Damm wrote:
> The sh7722 serial ports all lack SCSPTR registers, so mark them as
> nonexistent in the register table.

On Wed, Apr 23, 2008 at 09:37:39PM +0900, Magnus Damm wrote:
> Only write to hardware in SCI_OUT() if the register size is valid.

On Thu, Apr 24, 2008 at 09:30:09PM +0900, Magnus Damm wrote:
> This patch unifies the sh3 external irq pin code. It buys us some
> savings with reduced code redundancy, but the main feature with
> this change is irq sense selection support for all sh3 processors.

On Thu, Apr 24, 2008 at 09:36:34PM +0900, Magnus Damm wrote:
> This patch adds interrupt acknowledge code for external interrupt
> sources on sh3 processors. Only really required for edge triggered
> interrupts, but we ack regardless of sense configuration.

On Thu, Apr 24, 2008 at 09:41:12PM +0900, Magnus Damm wrote:
> Clean up the intc tables by removing unneeded #ifdefs. The vector
> list is what selects which interrupt sources that should be added,
> having unsupported bitfields listed is ok as long as the vector
> is excluded from the list.

On Thu, Apr 24, 2008 at 09:47:15PM +0900, Magnus Damm wrote:
> The processor models sh7706, sh7707 and sh7709 don't support high
> level trigger sense configuration. And the intc code looks like
> crap these days so what's the difference.

On Thu, Apr 24, 2008 at 09:53:07PM +0900, Magnus Damm wrote:
> Make sure register modifications stay atomic. Fixes processors with
> shared priority register masking. Dual bitmap masking is unaffected.

All applied, thanks.
