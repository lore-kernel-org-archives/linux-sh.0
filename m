From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 26 Oct 2010 06:50:01 +0000
Subject: Re: [PATCH] sh: i2c-sh7760: Replase from ctrl_* to __raw_*
Message-Id: <20101026065001.GC4733@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1287785220-5893-1-git-send-email-iwamatsu@nigauri.org> <20101025015835.GE2173@linux-sh.org> <20101025104718.GF21564@trinity.fluff.org> <20101025111324.GA16265@linux-sh.org> <20101025124211.GG21564@trinity.fluff.org> <AANLkTikh+h1nWHZCa29FQc1dw=z3ZhYEW8eSyFyS4C84@mail.gmail.com> <20101026040203.GB16265@linux-sh.org> <20101026064307.GH21564@trinity.fluff.org>
In-Reply-To: <20101026064307.GH21564@trinity.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-i2c@fluff.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Oct 26, 2010 at 07:43:07AM +0100, Ben Dooks wrote:
> On Tue, Oct 26, 2010 at 01:02:03PM +0900, Paul Mundt wrote:
> > On Tue, Oct 26, 2010 at 09:08:12AM +0900, Nobuhiro Iwamatsu wrote:
> > > 2010/10/25 Ben Dooks <ben-i2c@fluff.org>:
> > > > On Mon, Oct 25, 2010 at 08:13:25PM +0900, Paul Mundt wrote:
> > > >> On Mon, Oct 25, 2010 at 11:47:18AM +0100, Ben Dooks wrote:
> > > >> > On Mon, Oct 25, 2010 at 10:58:35AM +0900, Paul Mundt wrote:
> > > >> > > On Sat, Oct 23, 2010 at 07:07:00AM +0900, Nobuhiro Iwamatsu wrote:
> > > >> > > > ctrl_* is deprecated. We should to use __raw_*.
> > > >> > > >
> > > >> > > > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > > >> > >
> > > >> > > Applied, thanks.
> > > >> >
> > > >> > Hi, can you see my comments about the copy of this posted below
> > > >> > about ioremap() and use or __raw accessors?
> > > >> >
> > > >> No? At least it never made it to the list. Do you have a pointer handy?
> > > >
> > > > http://marc.info/?l=linux-i2c&m8797023230600&w=2
> > > >
> > > 
> > > Sorry, this is my mistake.
> > > 
> > > >> On Sun, Oct 24, 2010 at 05:37:46PM +0900, Nobuhiro Iwamatsu wrote:
> > > >> ctrl_* is deprecated. We should to use __raw_*.
> > > >
> > > >> Given iobase is ioremap() returned, there should be an explicit reason
> > > >> for using __raw_xxx() instead of read/writel().
> > > 
> > Based on what, exactly? The CPU in question is quite content with the
> > weak ordering provided by __raw_xxx(), anything more is unecessary.
> 
> generally, readX,writeX or iowriteX,ioreadX are the functions that should
> be used on ioremap()d memory. It may not be a hard rule, but it is how it
> is supposed to be done.
> 
Nonsense. There are plenty of cases in the kernel that use __raw_xxx() on
ioremapped memory and have been since before ioread/writeX even existed.
Whether to use read/writeX or the __raw versions has always been up to
the developer, and if the ordering issues don't factor in then there is
simply no reason to bother using read/writeX.

If you wish to do a kernel-wide audit and convert all __raw_xxx users on
ioremapped memory over you are certainly welcome to try. Inserting extra
memory barriers for strong ordering where it isn't needed however is
completely pointless.
