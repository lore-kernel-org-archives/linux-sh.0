From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Jun 2015 20:08:24 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <20150624200824.GV1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 24, 2015 at 07:37:45PM +0000, Joseph Myers wrote:
> On Wed, 24 Jun 2015, Rich Felker wrote:
> 
> > On Wed, Jun 24, 2015 at 02:10:06PM +0000, Joseph Myers wrote:
> > > On Wed, 24 Jun 2015, Rich Felker wrote:
> > > 
> > > > Nominally SH3 support remains in both the kernel and glibc. If it can
> > > > be established that multiple parties agree that there's really no one
> > > > left who cares about the old no-FPU sigcontext ABI on SH3, I will be
> > > > all for dropping it and unifying sigcontext.
> > > 
> > > Note that right now we have BE and LE versions of *three* ABIs for SH in 
> > > glibc (SH3 soft-float, SH4 soft-float, SH4 hard-float) (and as noted in 
> > > this discussion, right now each would only work properly on a kernel with 
> > > the corresponding configuration).  See 
> > > <https://sourceware.org/glibc/wiki/ABIList>.
> > 
> > Is your understanding that SH4 soft-float is using the SH4 ucontext_t
> > layout? I don't think it's even working at all. Glibc uses the layout
> 
> My understanding is what Kaz affirmed in 
> <https://sourceware.org/ml/libc-alpha/2014-01/msg00388.html>.  It's 
> entirely possible there are bugs (including regressions) in this area; if 
> so, they should be filed in Bugzilla.

OK, if that's the intent, I don't think it matches the present
reality. If I can confirm this I'll file a bug.

Rich
