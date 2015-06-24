From: Rob Landley <rob@landley.net>
Date: Wed, 24 Jun 2015 08:23:33 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <558A6905.7010406@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 06/24/2015 09:10 AM, Joseph Myers wrote:
> On Wed, 24 Jun 2015, Rich Felker wrote:
> 
>> Nominally SH3 support remains in both the kernel and glibc. If it can
>> be established that multiple parties agree that there's really no one
>> left who cares about the old no-FPU sigcontext ABI on SH3, I will be
>> all for dropping it and unifying sigcontext.
> 
> Note that right now we have BE and LE versions of *three* ABIs for SH in 
> glibc (SH3 soft-float, SH4 soft-float, SH4 hard-float) (and as noted in 
> this discussion, right now each would only work properly on a kernel with 
> the corresponding configuration).  See 
> <https://sourceware.org/glibc/wiki/ABIList>.
> 
> We can, of course, choose to declare processor or ABI variants no longer 
> supported in glibc, much like we desupported i386 in glibc (requiring i486 
> or later - albeit the official desupporting happening several years after 
> i386 would no longer build) or removed support for non-EABI ARM.  But 
> since we don't have an SH maintainer at all in glibc at present, it's 
> harder to make such a decision (whereas if an architecture maintainer 
> decided some variants were no longer relevant, they could just remove 
> support - make those variants give a configure-time error - in the absence 
> of someone objecting and willing to take over maintaining support for 
> those variants).
> 
> I think the next glibc change likely to require action from each 
> architecture's maintainer to avoid breaking the build may be Adhemerval's 
> cancellation changes - so if no-one comes forward as SH maintainer to at 
> least update SH for those changes when they are ready to go in, the build 
> for SH will be broken and that will indicate, as per 
> <https://sourceware.org/ml/libc-alpha/2015-06/msg00424.html>, that it may 
> be time to remove the port from glibc.

Eh, ping me when that happens. I may at least do necessary changes to
keep it building. (Although I can only test glibc on qemu-system-sh4.)

Rob

