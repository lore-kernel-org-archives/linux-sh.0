From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 20 May 2010 03:11:16 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 INTCS support
Message-Id: <20100520031116.GB6661@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311054221.27152.9839.sendpatchset@t400s>
In-Reply-To: <20100311054221.27152.9839.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 11, 2010 at 02:42:21PM +0900, Magnus Damm wrote:
> Add support for the sh7372 INTCS interrupt controller.
> 
> INTCS is the interrupt controller for the sh7372 SuperH
> processor core. It is tied into the INTCA interrupt
> controller which interfaces to the ARM processor.
> 
> INTCS support is implemented using a new INTC table
> together with a chained interrupt handler that ties
> into the already supported INTCA controller.

On Wed, May 12, 2010 at 06:03:19PM +0900, Magnus Damm wrote:
> Allow users to build the TMU driver on SH-Mobile ARM.

On Wed, May 12, 2010 at 11:21:14PM +0900, Magnus Damm wrote:
> [PATCH 01/02] ARM: mach-shmobile: Use shared clock framework
> [PATCH 02/02] ARM: mach-shmobile: sh7372 clock framework support V2

On Wed, May 19, 2010 at 07:29:47PM +0900, Magnus Damm wrote:
> Change INTCS_VECT_BASE from 0x3400 to 0x2200.
> 
> The old value 0x3400 gave the INTCA and INTCS interrupt
> conrollers separated spaces, but required ARM support
> for more than 512 NR_IRQS which is not in place at this
> point.
> 
> The value 0x2200 will make some of the INTCA interrupts
> make use of empty INTCS areas. This is a bit more error
> prone but works fine as a workaround for G3, G3 and AP4.

All applied, thanks.
