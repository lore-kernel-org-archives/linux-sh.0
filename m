From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 29 May 2020 14:35:15 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200529143515.GB25475@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200528221450.GF1079@brightrain.aerifal.cx>
In-Reply-To: <20200528221450.GF1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 28, 2020 at 06:14:51PM -0400, Rich Felker wrote:
> To follow up, I see that there was a patch series of yours (3/24) I
> missed ack'ing fairly recently. At first glance it looks good.

Well, I need a formal ACK, or even better have the arch maintainer
pick it up, as that is how development is normally supposed to work.

> In general, most of the patches I see are things that the linux-sh
> list and myself end up cc'd on that are only tangentially related to
> arch/sh or even not related at all. In that case I normally trust
> other maintainers familiar with the cross-arch changes being made that
> the small arch/sh part of the change is ok if the broader change is
> abstractly ok.

FYI, if you want to reduce the amount of crap you get Cced on, you can
add yourself to .get_maintainer.ignore file in the kernel tree, as
that at least removes a lot of the pass by cleanups found from git
log.

> Part of why I really disliked the "just kill it all" response to this
> thread is that the sh5 removal is specifically for the sake of making
> the arch more maintainable. That, along with forward-porting Sato's
> SH4 device tree patches (I've tried this but ran into problems, and
> need some help with it), has long been on my agenda for the arch, to
> reduce (and ultimately eliminate) the amount of legacy "only on
> arch/sh" stuff left so that it's not a burden on other maintainers and
> contributors. Seeing sentiment along the lines of "why don't you just
> remove it all while you're at it?" as a response is disheartening and
> also dismissive of Arnd's work making the sh5 removal happen.

We had the discussion before and things like the sh5 removal and
device tree switch came out of it.  But since then exactly nothing
has happened - the arch code is still pretty much unmaintained and
impossible to get a review for.  No one expects super quick responses
for a legacy architecture, but if there is no way to get feedback
or patches queued up while the code keeps on bitrotting the architecture
is effectively dead.  I have no personal problem with the sh hardware,
but if we want a Linux port to survive it will need at least a minimum
amount of active maintainance.
