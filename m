From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Jan 2008 10:52:29 +0000
Subject: Re: SH-Sci(f) driver as console
Message-Id: <20080131105229.GA15458@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1201776250.20171.72.camel@Atlas>
In-Reply-To: <1201776250.20171.72.camel@Atlas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 31, 2008 at 07:51:11PM +0900, Paul Mundt wrote:
> early_sci_setup() is provided for the cases where we want to set the port
> up early, but should probably be adjusted for a different pointer type.
> Perhaps the easiest thing to do is to take the early printk uart info and
> pass that in to early_sci_setup(), since we know we'll at least have
> something we can use early there.

And to elaborate on this, the idea was taken from 8250. Look at
early_serial_setup() and setup_early_serial8250_console() for more
information and ideas.
