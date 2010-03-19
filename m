From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Mar 2010 08:23:29 +0000
Subject: Re: [PATCH 01/05] dmaengine: shdma: Remove sh_dmae_slave_chan_id enum
Message-Id: <20100319082329.GD10003@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044638.17051.97049.sendpatchset@t400s>
In-Reply-To: <20100319044638.17051.97049.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 09:16:46AM +0100, Guennadi Liakhovetski wrote:
> On Fri, 19 Mar 2010, Magnus Damm wrote:
> > Reserving some number sounds like a good plan, but exactly what is the
> > best is a different question. If I'm allowed to nitpick then I think
> > its wasteful to use one bit for the sign when only needing one value
> > to mark unused. So I'd prefer to go with unsigned and 0 as unused mark
> > and the rest as valid ids.
> 
> Well, personally I somewhat dislike using 0 as an invalid ID (or invalid 
> IRQ...). Then you have to remember to use an offset:
> 
> 	if ((unsigned)slave_id >= SHDMA_SLAVE_NUMBER)
> 
> gets an oddition of "|| !slave_id", and you're wasting one bit in 
> sh_dmae_slave_used[];) And, as I said - extra typing:)
> 
I don't have any strong opinions on this one way or the other. If 0 =
disabled then this is the default behaviour people will end up with when
just sticking with default initialization, explicit slave ID setting will
trump this regardless.

I do generally prefer a -1 for explicitly disabling something since it
means someone has thought about it and wants that behaviour as opposed to
simply defaulting to it after clearing memory. However, there are also
many places in the kernel where 0 = invalid assumptions are hardcoded,
as with the IRQ case.

The difference between INT_MAX vs UINT_MAX is a pretty academic one in
terms of suitability for slave IDs, no CPU is going to approach either
one of those limits regardless.
