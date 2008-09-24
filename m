From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Sep 2008 16:43:05 +0000
Subject: Re: SH7722 serial scif
Message-Id: <20080924164305.GA20805@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
In-Reply-To: <878566.91579.qm@web26201.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 24, 2008 at 03:57:03PM +0000, Michael Trimarchi wrote:
> The problem is much simple. The code does't exit from the request_irq. I suppose,
> that kernel receive a very high number of interrupt requests. So this is the sequence:
> 
> ---->uart_open(2)
>            |
>              \-------request_irq
>           |
>           \------- start_tx
> 
> The first time the code run without problem. ( I recevive a packet of one byte every 60ms)
> 
> The simple program exit without problem.
> 
> I run again the program with this result:
> ---->uart_open(2)
>             |
>            \------request_irq
> 
> Never exist. So I think is releated to the shutdown sequence and startup. Adding
> the code above the problem disappear. 
> 
> Is ok now this description?
> 
Ok, that's interesting. There are a couple things to consider here:

	- startup/shutdown both set and clear the RX and TX IRQ enable
	  bits
	- the base SCSCR initialization is maintained across the lifetime
	  of the port, and is directly manipulated by the termios value.

We need the initialization in the set_termios path for things like the
system console, which can be suspended/resumed, as well as handling
rate changes directly (not related to the frequency notifier).

Given that, moving this out to the startup/shutdown path is definitely
not what we want to do, but we do need to figure out what your SCSCR
register state is at the time of startup and shutdown. There are a couple
of possibilities:

	- IRQ not properly acked and cleared at shutdown time, despite
	  the TX/RX bits being cleared.
	- Some bit setting in the SCSCR_INIT definition for your platform
	  that we need to be more careful in handling.

If we look at the setting for 7722, it's the usual mix of TE/RE/REIE and
nothing particularly exotic, so we can probably just swallow these up in
the sci_start_tx/rx()/sci_stop_tx/rx() pairs, and that should
subsequently get your SCSCR value pretty much back to 0 at shutdown time.
