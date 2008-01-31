From: "Kieran Bingham" <kieranbingham@gmail.com>
Date: Thu, 31 Jan 2008 18:09:58 +0000
Subject: Re: SH-Sci(f) driver as console
Message-Id: <82bcfa4d0801311009x4a0da049g1422eebbfa5b3292@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1201776250.20171.72.camel@Atlas>
In-Reply-To: <1201776250.20171.72.camel@Atlas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Urgh ... my head hurts from following this ENXIO error all the way
through sys_open, through VFS / VT / TTY and down to Uart :P

I think I went the long way round :( silly me !


I added
	early_sci_setup( &scif_port );

to the end of setup_early_printk(..);

This created the serial console that let it write out as a console
printk buffer, but when it comes to sys_open(ing) /dev/console, its
returning  with -ENXIO from uart_get in serial_core.c

	state->count++;
	if (!state->port || state->port->flags & UPF_DEAD) {
		DPRINTK("state->port = %x : state->port->flags = 0x%x\n",
state->port, state->port->flags);
		ret = -ENXIO;
		goto err_unlock;
	}

state->port comes out as 0.

Where is this supposed to be set up ? Is this because I've set my uart
port up too early, and something has missed it ? or am I just missing
something more fundamental ?
--

Cheers
KB

On 31/01/2008, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Jan 31, 2008 at 10:44:10AM +0000, Kieran Bingham wrote:
> > I'm having problems with the sh-sci driver as a console.
> >
> > The early printk code works for my board; I added the register
> > definitions into the sh-sci.h file.
> >
> > However, When it comes to register_console for the ttySC - at that
> > point, the uart's havent been registered, so the console doesn't attach,
> > failing at the line :
> >
> >
> > static int __init serial_console_setup(struct console *co, char
> > *options)
> > {
> > .
> > .
> > .
> > /*
> >  * Also need to check port->type, we don't actually have any
> >  * UPIO_PORT ports, but uart_report_port() handily misreports
> >  * it anyways if we don't have a port available by the time this is
> >  * called.
> >  */
> >
> >  if (!port->type)
> >       return -ENODEV;
> >
> > .
> > .
> > .
> > }
> >
> >  only later does uart_register_driver get called when static int __init
> > sci_init(void) runs.
> >
> > Do I need to change something to make the call to sci_init occur earlier
> > in the kernel ? or should I just call register console again later on
> > perhaps?
> >
> The uart and console driver are fairly orthogonal. While the port
> defs overlap, one does not intrinsically depend on the other.
>
> early_sci_setup() is provided for the cases where we want to set the port
> up early, but should probably be adjusted for a different pointer type.
> Perhaps the easiest thing to do is to take the early printk uart info and
> pass that in to early_sci_setup(), since we know we'll at least have
> something we can use early there.
>
