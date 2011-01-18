From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Jan 2011 04:50:23 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 INTCS MFIS2 interrupt update
Message-Id: <20110118045023.GJ2122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311054221.27152.9839.sendpatchset@t400s>
In-Reply-To: <20100311054221.27152.9839.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 18, 2011 at 12:13:44PM +0900, Magnus Damm wrote:
> Enable the MFIS2 interrupt source in the INTCS interrupt
> controller included in the sh7372 processor. The priority
> field is constantly enabled to let the interrupt through to
> both the ARM side and the SH side.

On Tue, Jan 18, 2011 at 12:41:04PM +0900, Magnus Damm wrote:
> set_irq_type() should only be used for external IRQ pins,
> so update the G3EVM board code to remove low level request.

Both applied, thanks.
