From: Rob Landley <rob@landley.net>
Date: Wed, 24 Jun 2015 07:12:58 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <558A587A.2010400@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



On 06/23/2015 11:52 PM, Rich Felker wrote:
> On Tue, Jun 23, 2015 at 11:25:08PM -0500, Rob Landley wrote:
>> On 06/20/2015 01:06 PM, Rich Felker wrote:
>>> So there's a lot of historical mess and breakage here, but sh3
>>> binaries have been running with a stable (albeit wrong, IMO)
>>> definition of ucontext_t/mcontext_t/sigcontext for around 14 years
>>> now (as long as they only run on sh3 hardware, not sh4). So I'm a bit
>>> hesitant to consider this something that could be changed with no path
>>> for compatibility.
>>
>> I'm told SH3 was only on sale for about a year between its introduction
>> and sh4 coming out, at which point everybody switched. There were
>> significant sh2 deployments and significant sh4 deployments, but sh3 was
>> more or less a rounding error. The Wikipedia[citation needed] article
>> doesn't even break it out separately because there's really nothing to
>> say: https://en.wikipedia.org/?title=SuperH
>>
>> (Again, there's a reason qemu-system-sh4 has a 4 in it. At $DAYJOB their
>> plan is to eventually jump from sh2 straight to sh4 because sh3 doesn't
>> matter.)
>>
>> sh2a was a retcon, started shipping in 2007, a decade after the
>> dreamcast. Hitachi had already unloaded superh onto Renesas, which did a
>> big Not Invented Here on superh and kept trying to come up with their
>> own processor designs. The H in H8300 also stands for Hitachi, so you
>> can imagine how well Renesas supported it:
>>
>> http://permalink.gmane.org/gmane.linux.ports.sh.devel/7237
>>
>> Seriously, It only became interesting again when the patents expired...
> 
> It's easy to declare SH3 irrelevant when we're not using it,

If nobody is using it it's irrelevant, yes.

> but if we
> want SH in general to be a serious platform moving forward, there
> needs to be proper attention to things like not breaking kernel
> API/ABI and a concern for consensus among users of the platform.

You're aware that modern x86 processors dropped support for the
binary-coded-decimal instructions in the original 8086, right? Obviously
x86 is not a serious platform...

You're saying that historically there have been multiple incompatible
ABIs, which nobody noticed the brokenness of for years (clone system
call arguments, etc) because _if_ anybody was still using them
(unlikely) they haven't upgraded their kernel in years. (We found things
that wouldn't build with a 4.x toolchain but the people building a lot
of this were using a 2.x toolchain and pthreads, not nptl...)

As part of your "unified" binary you want to invent a new file format
(ELF/fdpic combo) that uses a new system call trap number, and you're
going to patch the kernel to understand this new stuff due to a concern
about backwards compatibility...?

I've lost the plot here, is what I"m saying.

> Nominally SH3 support remains in both the kernel and glibc. If it can
> be established that multiple parties agree that there's really no one
> left who cares about the old no-FPU sigcontext ABI on SH3, I will be
> all for dropping it and unifying sigcontext.

Multiple parties like who?

If you feel it important to create infrastructure in search of a user
unless I can prove a negative, it's your libc. But I really, really,
really don't see the point. "This is the interesting subset." "But
somebody else might exist!" "Wait to hear from them?"

> Perhaps a good starting point would be making SH2 (and SH1 if it's
> even supported at all) use the SH4(/SH2A)-compatible sigcontext
> layout. For these, I think it's completely implausible that existing
> software depends on the layout.

Your post said the FPU is what changed the layout. I don't think sh2 had
an FPU? (Again, sh2a first shipped in 2007...)

I don't understand why you want a common abi between a nommu system and
an mmu system which did not historically have the same system calls or
even use the same binary format. What's the point?

> Rich

Rob
