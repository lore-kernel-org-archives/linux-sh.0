From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 29 May 2020 14:30:59 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200529143059.GA25475@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
In-Reply-To: <20200528161416.GY1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 28, 2020 at 12:14:16PM -0400, Rich Felker wrote:
> It is in active use. Please do not act on such a request. I would be
> much quicker to ack things that actually need ack if I weren't CC'd on
> hundreds of random non-arch-specific changes that don't need it, but I
> understand that's how the kernel process works. If there are things
> that need ack please feel free to ping.
> 
> Note that I specifically acked and requested the sh5 removal.

But you did not actually pick it up - because of that it still isn't
in linux-next and thus most likely will miss Linux 5.8.
