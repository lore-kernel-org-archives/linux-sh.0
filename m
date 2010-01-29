From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 29 Jan 2010 15:23:37 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <20100129152336.GA7388@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 29, 2010 at 01:53:59AM -0600, Rob Landley wrote:
> On Wednesday 27 January 2010 01:55:42 Paul Mundt wrote:
> > At what point in this thread was the compiler even mentioned? The entire
> > topic of the thread relates only to gas, kindly refrain from making up
> > imaginary problems, thanks.
> 
> You're right, the compiler never seems to emit code that triggers this bug, 
> you have to hand-write assembly to do it, and intentionally ask the assembler 
> to do something it can't do.
> 
The only reason the assembler choked on it was because the assembler
was buggy, is that so hard for you to get your head around? And
unsurprisingly, other bugs in the kernel were caught and fixed as a
result of this change.

> So the official position of the maintainer of the Super Hitachi port is that any 
> toolchain older than October 16th (the binutils 2.20 release) is too old to 
> build the Linux kernel.  (With the corollary that in the 5 years since the PC 
> went 64 bit, apparently nobody ever actually tried to build anything for Super 
> Hitachi?)
> 
For starters, the only Super Hitachi in existence is a train, which has
nothing to do with me or with my employer.

Anything older than the 2.20 binutils release will have this particular
bug with sign extension on 64-bit hosts. The fact we only recently
introduced a change that triggered this bug in the assembler doesn't
change the fact that it was always there, and remains a legitimate
usecase. Having said that, we could work around it, yes, but so far there
hasn't been sufficient reason to do so. 

If you'd like to cite a technical reason for why you are unable to move
your version of binutils forward, then we can look in to that. If you're
primarily intent on whining and posturing, don't bother Ccing me.

> Meanwhile Documentation/Changes still says binutils 2.12, and other 
> architectures _never_ work around bugs in older toolchains (*cough* git 
> 2a4b9c5af8203 *cough*)...
> 
Documentation/Changes also only states "minimal" requirements, which are
obviously not going to be consistent across platforms. If you think it
means anything other than that, you are sorely misinformed. Most
platforms can't build the kernel with the toolchain requirements outlined
therein today, something that is abundantly obvious to anyone that spends
even a cursory amount of time actually working on the code.
