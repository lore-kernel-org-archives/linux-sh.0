From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Jul 2008 03:55:55 +0000
Subject: Re: sh64 build error - sh, kbuild or binutils problem?
Message-Id: <20080704035555.GB7247@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <8763rng2q0.wl%ysato@users.sourceforge.jp>
In-Reply-To: <8763rng2q0.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 03, 2008 at 08:24:52PM -0400, Yoshinori Sato wrote:
> At Thu, 3 Jul 2008 19:03:23 +0900,
> Paul Mundt wrote:
> > 
> > On Wed, Jul 02, 2008 at 09:45:27PM -0400, Yoshinori Sato wrote:
> > > At Sun, 1 Jun 2008 14:30:47 +0900,
> > > Paul Mundt wrote:
> > > > 
> > > > On Sat, May 31, 2008 at 11:22:39PM +0300, Adrian Bunk wrote:
> > > > > Minimal example demonstrating the problem:
> > > > > 
> > > > > $ sh64-linux-ar rcs tmp.o
> > > > > $ sh64-linux-ld -EL -r -o tmp2.o tmp.o
> > > > > $ sh64-linux-ld -EL -r -o out.o tmp2.o 
> > > > > sh64-linux-ld: sh3 architecture of input file `tmp2.o' is incompatible with sh5 output
> > > > > $ 
> > > > > 
> > > > Yes, it's a binutils bug. I've hit this on SH-2A zImage builds too, and
> > > > hacked together a patch for it. I'll see about fixing it up fo sh64 too
> > > > and then posting it to the list.
> > > 
> > > I think ld is strict machine type check.
> > > 
> > > This is workaround.
> > > SH-2A build success.
> > > 
> > This is probably a reasonable workaround until fixed versions of binutils
> > are more readily available. Please re-send this with a Signed-off-by and
> > I'll add it to my queue.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
Applied, thanks.
