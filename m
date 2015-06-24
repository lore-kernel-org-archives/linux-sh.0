From: Rich Felker <dalias@libc.org>
Date: Wed, 24 Jun 2015 04:52:24 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <20150624045224.GO1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 23, 2015 at 11:25:08PM -0500, Rob Landley wrote:
> On 06/20/2015 01:06 PM, Rich Felker wrote:
> > So there's a lot of historical mess and breakage here, but sh3
> > binaries have been running with a stable (albeit wrong, IMO)
> > definition of ucontext_t/mcontext_t/sigcontext for around 14 years
> > now (as long as they only run on sh3 hardware, not sh4). So I'm a bit
> > hesitant to consider this something that could be changed with no path
> > for compatibility.
> 
> I'm told SH3 was only on sale for about a year between its introduction
> and sh4 coming out, at which point everybody switched. There were
> significant sh2 deployments and significant sh4 deployments, but sh3 was
> more or less a rounding error. The Wikipedia[citation needed] article
> doesn't even break it out separately because there's really nothing to
> say: https://en.wikipedia.org/?title=SuperH
> 
> (Again, there's a reason qemu-system-sh4 has a 4 in it. At $DAYJOB their
> plan is to eventually jump from sh2 straight to sh4 because sh3 doesn't
> matter.)
> 
> sh2a was a retcon, started shipping in 2007, a decade after the
> dreamcast. Hitachi had already unloaded superh onto Renesas, which did a
> big Not Invented Here on superh and kept trying to come up with their
> own processor designs. The H in H8300 also stands for Hitachi, so you
> can imagine how well Renesas supported it:
> 
> http://permalink.gmane.org/gmane.linux.ports.sh.devel/7237
> 
> Seriously, It only became interesting again when the patents expired...

It's easy to declare SH3 irrelevant when we're not using it, but if we
want SH in general to be a serious platform moving forward, there
needs to be proper attention to things like not breaking kernel
API/ABI and a concern for consensus among users of the platform.
Nominally SH3 support remains in both the kernel and glibc. If it can
be established that multiple parties agree that there's really no one
left who cares about the old no-FPU sigcontext ABI on SH3, I will be
all for dropping it and unifying sigcontext.

Perhaps a good starting point would be making SH2 (and SH1 if it's
even supported at all) use the SH4(/SH2A)-compatible sigcontext
layout. For these, I think it's completely implausible that existing
software depends on the layout.

Rich
