From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 21 Mar 2008 08:49:49 +0000
Subject: Re: Fixing up unaligned userspace access
Message-Id: <20080321084949.GB17623@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
In-Reply-To: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 14, 2008 at 02:10:59PM +0000, Kieran Bingham wrote:
> Fixing up unaligned userspace access in "unaligned-acces" pidW
> pc=0x0cfa0116 ins=0x0009
> instruction : 9
> 
> Code from above:
> 
> 0CFA010A 0009              NOP
> 0CFA010C 0009              NOP
> 0CFA010E 0009              NOP
> 0CFA0110 51E1              MOV.L     @(H'04:4,R14),R1    # R1 is
> 0x4466 at this point
> 0CFA0112 6112              MOV.L     @R1,R1
> 0CFA0114 1E13              MOV.L     R1,@(H'0C:4,R14)
> 0CFA0116 0009              NOP
> 0CFA0118 0009              NOP
> 0CFA011A 0009              NOP
> 
> 
> Is there some sort of timing issue here where by the time the
> exception is raised, the CPU has already started to execute the
> following instructions ? Something in a pipeline perhaps ? Surely when
> an address error occurs - thats it - it should stop ? But maybe I'm
> missing something...
> 
It would be helpful to know what the stack layout is at the time you
enter the exception, both from HEW and from regular processing. The saved
PC value in this case is the next instruction to be executed, and even if
it's partially split out in the pipeline, the exec stage should not be
hit until execution resumes.

Looking at address_error_trap_handler(), I wonder if we have an
inconsistency between the stack-relative saved (ie, OFF_PC) PC and the
saved PC on the top of the stack pushed by the hardware on top of the
saved SR before the processing begins. You may wish to pop the saved PC
off and toss that in r7 or some such thing so you can more easily
compare. The only issue is that the hardware-saved PC at the top of the
stack can occasionally be undefined (ie, in the case of nested
exceptions), in which case we have to go to the OFF_PC value on-stack
regardless. This is fairly easy to test for however.
