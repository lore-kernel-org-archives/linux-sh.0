From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 27 Dec 2007 08:59:51 +0000
Subject: Re: [Patch] Add support for Poseidon board.
Message-Id: <20071227085951.GA26068@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4773637D.7000702@invitel.hu>
In-Reply-To: <4773637D.7000702@invitel.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 27, 2007 at 09:34:05AM +0100, Heiko Schocher wrote:
> Paul Mundt wrote:
> > Please kill this io.c completely. If the generic routines don't work for
> > you, we can look at conditionalizing timeouts there if it's absolutely
> > needed. Other architectures have similar hooks for broken platforms.
> 
> I played with the Bus-timing registers, but without any success :-(
> When I disable the cache it works fine with the generic io routines!
> 
> Now I dont know, if we have to modify the generic routines, because
> I think its a really special problem for me, and that shouldnt go into
> generic routines, or?

SLOW_DOWN_IO can be done generically. Look at mips or x86 for an example.

There's no reason to define it for anyone else, and it will be
pre-processed away.
