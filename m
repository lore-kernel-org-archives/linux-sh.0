From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 00:12:26 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <87y4z822hj.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> My comment was more about code/size optimizations: if you declare
> du_resources[] as a local (non-static) variable on the stack, the compiler
> has to construct it on the stack. For basic data types (e.g. int, long) this
> requires not that much code (the variable may end up in a register), but
> for more complex structures, the compiler may emit quite some code,
> making it more economic to make the variable static.
> For functions that are called multiple times (which is not the case here),
> there's another reason to use static: the variable on the stack will be
> constructed on every function call, over and over again.

Thank you for explaining about detail of that.
I understood.
But, I wonder is it so big issue ?
Because, these are called only when kernel booting,
and only once.

And, these functions has __init.
Then, what happen after initialization if I add static in local variable ?
Was static variable keeped ? or removed ?

But, anyway, this patch will not be used...
