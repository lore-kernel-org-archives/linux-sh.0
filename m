From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 14 Feb 2013 12:38:11 +0000
Subject: Re: [PATCH/RFC 1/3] pinctrl: sh-pfc: support sparse GPIO numbers
Message-Id: <20130214123810.GB3882@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 01:09:09PM +0100, Laurent Pinchart wrote:
> On Thursday 14 February 2013 20:55:16 Paul Mundt wrote:
> > On Tue, Feb 12, 2013 at 04:50:02PM +0100, Guennadi Liakhovetski wrote:
> > > Not on all sh-/r-mobile platfotms all pins are numbered contiguously from
> > > 0 to N-1. On all ARM-based platforms datasheets use simple numbers to
> > > identify them, unlike some SuperH-based SoC, naming pins, using strings,
> > > e.g. A31:A0, B11:B0, C31:C0, etc. So far the sg-pfc pinctrl driver
> > > supported only contiguous pin numbering. This patch adds support for
> > > sparse pin numbers to support sh73a0 and any other similar SoCs.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > The sh-pfc pinctrl driver is not the place where this sort of lookup
> > should be happening, especially as the pinctrl subsystem already tracks
> > GPIO ranges for us. Is there some reason you can't just expand the
> > platform definition and tie in to pinctrl_add_gpio_ranges() for
> > supporting multiple ranges instead?
> 
> Using pinctrl_add_gpio_ranges() was also my initial idea. While I think it's 
> still useful, there's one issue it doesn't fix: GPIO numbering in DT and 
> sysfs. On the sh73a0 platform the GPIO_PORT* enumerated values don't match the 
> port number. While that's not a major issue in board code that uses the enum 
> names, this would become very confusing in DT and sysfs. GPIO 128, for 
> instance, would be referenced by the number 119 in DT.
> 
If that's the case, then why are you using integers in DT instead of
something like a string that you can map back? Granted I haven't seen the
bindings documentation or proposal, so I have no idea what the interface
looks like, but I'm not convinced that it's worthwhile adding an
additional translation layer simply because the DT interface can't do 1:1
mappings for whatever reason (although if necessary I suppose this
translation layer could always be implemented purely in the OF side of
the sh-pfc support, handing off sane ranges to the core at registration
time).

> I think we should fix that and use the port number in the GPIO API. This 
> requires translating from the port number to the GPIO entry index in internal 
> pinmux_pins[] array. There are several way to do so, one is to index the array 
> by the port number (and thus making it sparse, using more memory), the other 
> is to add a list of ranges (either explicitly as in Guennadi's patch, or 
> implicitly by adding the port number to each entry in the pinmux_pins[] array 
> and computing the list of ranges at init time). I haven't decided yet which 
> solution I like the best, I'm experimenting with both.
> 
If this is the way things need to go, then doing it sparsely makes sense,
but not in the proposed form, and there's no real need for it to use
excessive amounts of memory. We already went through all of this once in
the irq_desc[] to sparseirq conversion, and there's no reason why the
same approach wouldn't be able to carry over for this, either.

At the very simplest you can simply allocate an array of pointers and
lazily map those back to the pin mappings, so you only waste a pointer
rather than a pinmux_pin struct. Alternately you can insert in to a radix
tree, which would permit you to stash the mapping directly, as well as
any additional translation logic in the node's slot (you could also
handle mixing and matching DT vs non-DT GPIOs by tagging the entry), and
eliminate the sparse array overhead entirely.
