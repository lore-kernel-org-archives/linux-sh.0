From: Rich Felker <dalias@libc.org>
Date: Fri, 14 Aug 2015 01:10:27 +0000
Subject: Re: SH2 kernel fails to build with recent GCC
Message-Id: <20150814011027.GG31018@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150812015616.GA19843@brightrain.aerifal.cx>
In-Reply-To: <20150812015616.GA19843@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 12, 2015 at 10:01:49AM -0400, Rich Felker wrote:
> On Wed, Aug 12, 2015 at 09:34:32AM +0200, Geert Uytterhoeven wrote:
> > Hi Rich,
> > 
> > On Wed, Aug 12, 2015 at 3:56 AM, Rich Felker <dalias@libc.org> wrote:
> > > The commit that resolved GCC issue #54089 broke building the kernel
> > > for SH2, by causing GCC to generate calls to new libgcc functions
> > > which the kernel's fake libgcc does not provide. See the GCC issue
> > > tracker for details:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?idT089
> > >
> > > The relevant commit is linked from comment 16; comments 33-43 (and
> > > perhaps beyond) discuss the issue in detail and possible fixes.
> > >
> > > Before I work on a fix, would dropping the kernel's copy of libgcc
> > > functions for SH and using the real libgcc (like some archs do; see
> > > comment 43) be acceptable, or do we need to get updated
> > > libgcc[-compatible] code into the kernel?
> > 
> > Which libgcc functions are missing? I couldn't find that list in the bug
> > report...
> 
> At least __ashlsi3_r0 and __lshrsi3_r0. It's been a while since I
> tried building with an affected GCC (see the dates on the comments I
> linked) so I don't remember if there were any others. I can try to
> build again and let you know.

I just retried the build and confirmed that these are the only two
unresolved symbols reported. So just adding them sounds practical.

Rich
