From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 26 Nov 2009 11:46:29 +0000
Subject: Re: [PATCH 1/2] sh: mach-ecovec24: modify memory area calculation
Message-Id: <20091126114629.GB6612@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 26, 2009 at 08:08:17PM +0900, Kuninori Morimoto wrote:
> 
> Dear Matt
> 
> Thank you for checking patch !!
> 

No problem.

> > I think both of these patches should be using the variable
> > "cached_to_uncached", rather than hard coding the value 0x20000000.
> 
> I didn't know cached_to_uncached.
> But I wonder can I use this variable here (romImage) ?
> I think we can use macro here, but can not variable.
> 

Ah, sorry, I forgot that this is a romImage thing. Yeah, including
system_32.h causes lots of assembler errors to appear so I'm guessing it
was never intended to be included by assembly code.
