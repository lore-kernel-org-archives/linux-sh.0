From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 25 Nov 2010 16:10:47 +0000
Subject: Re: [PATCH] SuperH on-chip EHCI glue
Message-Id: <Pine.LNX.4.44L0.1011251107560.22247-100000@netrider.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101125080349.GG3270@linux-sh.org>
In-Reply-To: <20101125080349.GG3270@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 26 Nov 2010, Paul Mundt wrote:

> On Thu, Nov 25, 2010 at 10:46:04AM -0500, Alan Stern wrote:
> > On Thu, 25 Nov 2010, Paul Mundt wrote:
> > > +	.relinquish_port		= ehci_relinquish_port,
> > > +	.port_handed_over		= ehci_port_handed_over,
> > > +};
> > 
> > You are missing the .endpoint_reset and .ehci_clear_tt_buffer_complete 
> > members.  This is a little surprising -- it implies the driver was 
> > written by copying another one that didn't have these things, meaning 
> > it must have been pretty old.
> > 
> I based it on ehci-atmel, which had a similar need for the clock
> framework interfacing. I'll add in the two that you noticed, but if I'm
> behind on some API changes, is there something else I should be looking
> at?

Not that I know of.

A quick check shows that ehci-mxc.c and ehci-w90x900.c are also missing
these methods.  I'm sure that at one point all the existing drivers had
them.  Could you look into adding the missing methods to all the
drivers that need them?

Alan Stern

