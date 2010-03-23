From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 08:39:59 +0000
Subject: Re: [PATCH] SH: extend SCI DMA support to work on SCIFA ports
Message-Id: <20100323083959.GC30655@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1003191452370.5412@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1003191452370.5412@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 23, 2010 at 09:39:26AM +0100, Guennadi Liakhovetski wrote:
> On Tue, 23 Mar 2010, Paul Mundt wrote:
> 
> > On Fri, Mar 19, 2010 at 02:53:04PM +0100, Guennadi Liakhovetski wrote:
> > > @@ -1407,8 +1429,21 @@ static void sci_shutdown(struct uart_port *port)
> > >  static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
> > >  			    struct ktermios *old)
> > >  {
> > > +#ifdef CONFIG_SERIAL_SH_SCI_DMA
> > > +	struct sci_port *s = to_sci_port(port);
> > > +#endif
> > >  	unsigned int status, baud, smr_val, max_baud;
> > >  	int t = -1;
> > > +	u16 scfcr = 0;
> > > +
> > > +	/*
> > > +	 * define SH_SCI_LOOPBACK_LINE to the number of the serial interface
> > > +	 * to put it in the loopback mode
> > > +	 */
> > > +#ifdef SH_SCI_LOOPBACK_LINE
> > > +	if (port->line = SH_SCI_LOOPBACK_LINE)
> > > +		scfcr |= 1; /* Loopback - testing mode */
> > > +#endif
> > >  
> > What's this all about? If this is something you think is useful enough to
> > add, it should probably be a module parameter and be settable from the
> > command line.
> 
> Yes, I thought it was useful enough to add, but not useful enough to 
> export as a module parameter;) So, if you don't like it like this, let's 
> just remove it.
> 
I don't have any problem with it as a module param, but that's a separate
patch. I'll strip this out of the DMA patch for now, and if you feel like
sending one for the module param then I'll apply that over top. Up to you
though!
