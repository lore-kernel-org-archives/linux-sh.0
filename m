From: Nicolas Pitre <nicolas.pitre@linaro.org>
Date: Thu, 20 Jan 2011 21:30:27 +0000
Subject: Re: Locking in the clk API
Message-Id: <alpine.LFD.2.00.1101201623480.8580@xanadu.home>
List-Id: <linux-sh.vger.kernel.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
	<20110120185617.GI6335@n2100.arm.linux.org.uk>
In-Reply-To: <20110120185617.GI6335@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, 20 Jan 2011, Russell King - ARM Linux wrote:

> On Thu, Jan 20, 2011 at 04:29:15PM +0000, Ben Dooks wrote:
> > I really don't like the fact that people are doing these things in
> > atomic contexts, and I think we should apply some pressure to move
> > the atomic caller cases to use systems where they can sleep such as
> > using threaded-irq handlers (they work very nicely)
> 
> How do you ensure that printk is always called from a non-atomic
> context?

Is this a good example?  I don't think that power sensitive systems such 
as a cellphone should keep printk() enabled in the final product.  The 
output from printk() over a serial port is a debugging convenience, and 
trying to aggressively turn on/off the serial clock around each call to 
printk() is a bit silly.  Better simply turn the serial clock on 
whenever its console facility is opened, and turn it off when the 
console is closed, which should be good enough in that context.


Nicolas
