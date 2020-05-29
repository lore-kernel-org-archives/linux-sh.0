From: Rich Felker <dalias@libc.org>
Date: Fri, 29 May 2020 17:53:38 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200529175335.GK1079@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
In-Reply-To: <20200529143059.GA25475@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, May 29, 2020 at 07:30:59AM -0700, Christoph Hellwig wrote:
> On Thu, May 28, 2020 at 12:14:16PM -0400, Rich Felker wrote:
> > It is in active use. Please do not act on such a request. I would be
> > much quicker to ack things that actually need ack if I weren't CC'd on
> > hundreds of random non-arch-specific changes that don't need it, but I
> > understand that's how the kernel process works. If there are things
> > that need ack please feel free to ping.
> > 
> > Note that I specifically acked and requested the sh5 removal.
> 
> But you did not actually pick it up - because of that it still isn't
> in linux-next and thus most likely will miss Linux 5.8.

Arnd sent the pull request for this and I expected it to be pulled
from his tree, since he already had my approval for the change. Maybe
Linus was expecting it to come through me. This seems to have been a
miscommunication.

Frustratingly, I _still_ don't have an official tree on kernel.org for
the purpose of being the canonical place for linux-next to pull from,
due to policies around pgp keys and nobody following up on signing
mine. This is all really silly since there are ridiculously many
independent channels I could cryptographically validate identity
through with vanishing probability that they're all compromised. For
the time being I'll reactivate my repo on git.musl-libc.org.

Rich
