From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Jan 2008 10:51:11 +0000
Subject: Re: SH-Sci(f) driver as console
Message-Id: <20080131105111.GA15324@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1201776250.20171.72.camel@Atlas>
In-Reply-To: <1201776250.20171.72.camel@Atlas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 31, 2008 at 10:44:10AM +0000, Kieran Bingham wrote:
> I'm having problems with the sh-sci driver as a console.
> 
> The early printk code works for my board; I added the register
> definitions into the sh-sci.h file.
> 
> However, When it comes to register_console for the ttySC - at that
> point, the uart's havent been registered, so the console doesn't attach,
> failing at the line :
> 
> 
> static int __init serial_console_setup(struct console *co, char
> *options)
> {
> .
> .
> .
> /*
>  * Also need to check port->type, we don't actually have any
>  * UPIO_PORT ports, but uart_report_port() handily misreports
>  * it anyways if we don't have a port available by the time this is
>  * called.
>  */
> 
>  if (!port->type)
> 	return -ENODEV;
> 
> .
> .
> .
> }
> 
>  only later does uart_register_driver get called when static int __init
> sci_init(void) runs.
> 
> Do I need to change something to make the call to sci_init occur earlier
> in the kernel ? or should I just call register console again later on
> perhaps?
> 
The uart and console driver are fairly orthogonal. While the port
defs overlap, one does not intrinsically depend on the other.

early_sci_setup() is provided for the cases where we want to set the port
up early, but should probably be adjusted for a different pointer type.
Perhaps the easiest thing to do is to take the early printk uart info and
pass that in to early_sci_setup(), since we know we'll at least have
something we can use early there.
