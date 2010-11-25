From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 25 Nov 2010 15:53:16 +0000
Subject: Re: [PATCH] SuperH on-chip EHCI glue
Message-Id: <20101125155315.GA2053@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101125080349.GG3270@linux-sh.org>
In-Reply-To: <20101125080349.GG3270@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 25, 2010 at 10:46:04AM -0500, Alan Stern wrote:
> On Thu, 25 Nov 2010, Paul Mundt wrote:
> > +	.relinquish_port		= ehci_relinquish_port,
> > +	.port_handed_over		= ehci_port_handed_over,
> > +};
> 
> You are missing the .endpoint_reset and .ehci_clear_tt_buffer_complete 
> members.  This is a little surprising -- it implies the driver was 
> written by copying another one that didn't have these things, meaning 
> it must have been pretty old.
> 
I based it on ehci-atmel, which had a similar need for the clock
framework interfacing. I'll add in the two that you noticed, but if I'm
behind on some API changes, is there something else I should be looking
at?
