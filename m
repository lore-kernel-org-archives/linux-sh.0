From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Thu, 02 Jul 2015 19:23:49 +0000
Subject: Re: [musl] Re: SH sigcontext ABI is broken
Message-Id: <alpine.LFD.2.11.1507022016190.31747@eddie.linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, 20 Jun 2015, Rob Landley wrote:

> >>>> Thanks, but most of the links seem to be broken.
> >>>
> >>> Are they?  I'm only seeing a single broken link, which has a mirror.
> >>
> >> My bad. Indeed only the davej one is broken, but that's where the code
> >> must have been introduced (even the earliest commit in tglx
> >> history.git has the #ifdef __SH4__ for FPU regs) and I can't find a
> >> cgit interface to it. Fetching several GB to browse history locally is
> >> going to take a while if I have to do that..
> > 
> > Using web interfaces for archeology doesn't fly.
> > If you're doing serious Linux work, you should already have a git repository
> > of the kernel. full-history-linux.git.tar weights in at only ca. 0.5 giB.
> 
> I have a somewhat updated version of that at
> http://landley.net/kdocs/local/linux-fullhist.tar.bz2 which I should
> probably update for the 4.0 release. (It's pulled to 3.0 currently.)

 For the record the LMO tree <git://git.linux-mips.org/pub/scm/ralf/linux> 
has a full history recorded and is in sync with kernel.org.  There's some 
GIT magic that cuts some operations like `git log' at 2.6.12-rc2, but you 
can go beyond that if you know the right commit id, e.g.:

$ git log -p 66f0a432 -- arch/sh

I can see the initial SH import was with 2.3.19.

  Maciej
