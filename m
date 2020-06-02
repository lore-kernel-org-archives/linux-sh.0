From: Rich Felker <dalias@libc.org>
Date: Tue, 02 Jun 2020 02:53:02 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <20200602025301.GZ1079@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de>
 <20200601181259.GV1079@brightrain.aerifal.cx>
 <20200602013332.GY1079@brightrain.aerifal.cx>
 <20200601194936.244303d858d2d0c47fc87821@linux-foundation.org>
In-Reply-To: <20200601194936.244303d858d2d0c47fc87821@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jun 01, 2020 at 07:49:36PM -0700, Andrew Morton wrote:
> On Mon, 1 Jun 2020 21:33:32 -0400 Rich Felker <dalias@libc.org> wrote:
> 
> > Hmm, it looks like Andrew Morton just pulled most of these into -mm,
> > apparently independently of me getting them in my for-next a few hours
> > ago, since his versions lack my signed-off-by. That's ok though, as
> > long as they go up. Some details since further action is needed on a
> > few:
> 
> It would be better if these were to go via the sh tree.  So please go
> ahead and merge them up - I'll drop my copies when they turn up in
> -next via the sh tree.

OK. That simplifies things a bit. Thanks.

Rich
