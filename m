From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 06 Jan 2016 18:57:16 +0000
Subject: Re: [PATCH v2 31/32] sh: support a 2-byte smp_store_mb
Message-Id: <CAMuHMdU8TW7pqhR401UBT1k4EjV=rZCBt2RmmQbobeCt34dULw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
	<1451572003-2440-32-git-send-email-mst@redhat.com>
	<20160105232735.GC238@brightrain.aerifal.cx>
	<20160106131321-mutt-send-email-mst@redhat.com>
	<20160106114023.GU6344@twins.programming.kicks-ass.net>
	<20160106134301-mutt-send-email-mst@redhat.com>
	<20160106143218.GV6344@twins.programming.kicks-ass.net>
	<568D35EB.7090108@landley.net>
In-Reply-To: <568D35EB.7090108@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Peter Zijlstra <peterz@infradead.org>, "Michael S. Tsirkin" <mst@redhat.com>, Rich Felker <dalias@libc.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Jeff Dionne <jeff@uclinux.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Wed, Jan 6, 2016 at 4:42 PM, Rob Landley <rob@landley.net> wrote:
> That said, if you'd ack a submission, Rich already has my Acked-by line
> on a maintainers patch (AND one to remove the extra cc's from the sh
> kernel list, and I acked Chen Gang's syscall addition patch back in
> https://lkml.org/lkml/2015/6/20/193 but nobody noticed...)

If you want patches for orphan architectures to be picked up, you should
CC Andrew Morton...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
