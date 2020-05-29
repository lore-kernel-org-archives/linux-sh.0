From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 29 May 2020 18:22:17 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200529182217.GA11203@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
In-Reply-To: <20200529175335.GK1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, May 29, 2020 at 01:53:38PM -0400, Rich Felker wrote:
> Frustratingly, I _still_ don't have an official tree on kernel.org for
> the purpose of being the canonical place for linux-next to pull from,
> due to policies around pgp keys and nobody following up on signing
> mine. This is all really silly since there are ridiculously many
> independent channels I could cryptographically validate identity
> through with vanishing probability that they're all compromised. For
> the time being I'll reactivate my repo on git.musl-libc.org.

You don't need a kernel.org tree.  None of the trees I maintain are
hosted on kernel.org.  Just make sure you sign your tags.
