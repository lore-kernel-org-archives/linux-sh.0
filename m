From: Rob Landley <rob@landley.net>
Date: Thu, 28 May 2020 22:28:19 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <89155328-93ea-662f-389e-f4500cfdf79c@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org> <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200528221450.GF1079@brightrain.aerifal.cx>
In-Reply-To: <20200528221450.GF1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 5/28/20 5:14 PM, Rich Felker wrote:
> Aside from that, the open source & open hardware J-core models are
> still active and in development, with the latest release having been
> made this month, and the J32 with MMU nearly complete and pending
> release, contingent mostly on integration and testing with Linux.

J-core's doing stuff:

https://github.com/j-core

https://www.prnewswire.com/news-releases/spacechain-foundation-invests-in-core-semiconductor-to-produce-open-hardware-platform-for-direct-satellite-to-devices-communication-301061761.html

https://www.reddit.com/r/IAmA/comments/gs7qpn/we_are_jeff_garzik_and_jeff_dionne_and_we_are/

And I note that I worked a year long contract in 2018 porting an existing sh4
Windows CE board to Linux (as a field upgrade to a widely deployed building
control system with a big stock of parts to build replacement units), so
conventional superh isn't exactly dead either.

Rob
