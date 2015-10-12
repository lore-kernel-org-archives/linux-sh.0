From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Oct 2015 00:42:08 +0000
Subject: Re: Code execution in suid binaries via FDPIC_FUNCPTRS personality inheritance, affects at least SH
Message-Id: <CA+55aFwi4sLPmeNKycJ3KXBT1Ycx8gfS06SSPqzA8EzhLnCvmQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Oct 11, 2015 at 9:46 AM, Rich Felker <dalias@libc.org> wrote:
> By causing a non-FDPIC-ABI program to inherit the FDPIC_FUNCPTRS
> personality on archs where FDPIC is supported (SuperH, FRV, Blackfin),
> an attacker can cause the kernel to interpret function pointers passed
> to sigaction as function descriptors, and thereby set the program
> counter to an address determined by the program text at the start of
> the signal handling function. FRV and Blackbin are generally NOMMU
> architectures anyway where local security cannot be expected since
> memory protection does not exist, but most modern SuperH models have
> MMU and users have a legitimate expectation of privilege enforcement

I doubt there is any SH/FRV/BlackFin people on the security list.

And since I also suspect those architectures aren't all that critical
for security issues, I'd suggest just posting this to the relevant
people directly. So

 - Andrew Morton and linux-sh@vger.kernel.org for SuperH
 - David Howells for FRV
 - Steven Miao for blackfin.

I'm quoting the rest of the email for the new people, but my guess is
that FDPIC_FUNCPTRS should just be part of PER_MASK, and I doubt it
really affects existing programs or that we care. But the actual
people involved may have different opinions.

                    Linus

-- snip snip --
>
> For reference, here is the code affected by the setting of this
> personality bit:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/sh/kernel/signal_32.c?idJ06c8ac2fb3ef484579ce44f9b809bd310fad48#n313
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/frv/kernel/signal.c?idJ06c8ac2fb3ef484579ce44f9b809bd310fad48#n217
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/blackfin/kernel/signal.c?idJ06c8ac2fb3ef484579ce44f9b809bd310fad48#n171
>
> Allocation of the value for FDPIC_FUNCPTRS outside of PER_MASK was a
> mistake; this bit is an ABI switch rather than a mere tweak, and
> should never be inherited across exec. This bug can be triggered even
> in non-malicious settings simply by executing a non-FDPIC program from
> one that's running as FDPIC.
>
> Really, signal handlers as function descriptors should have been done
> with a SA_FUNCDESC flag in sa_flags, not as a personality, but sadly
> that ship has already sailed; fixing it would break all existing
> binaries for these platforms which would be unaware of a newly-added
> flag.
>
> The fix which most respects compatibility with stable userspace ABI is
> to simply change PER_MASK to 0x00800ff so that FDPIC_FUNCPTRS is
> cleared on exec. However non-ELF binary formats are still affected
> since their loaders do no properly call SET_PERSONALITY at exec time.
> At least binfmt_aout.c and binfmt_flat.c should be fixed to clear the
> bit as well, either by calling SET_PERSONALITY or in some other
> manner.
>
> Alternatively, the value of FDPIC_FUNCPTRS could be changed to put it
> in the existing PER_MASK space, but this would violate the principle
> of not breaking userspace: Since FDPIC ELF files get loaded with the
> normal ELF loader when CONFIG_MMU is set, their entry point code
> should call personality() explicitly to setup the correct ABI, and
> thus userspace has to be aware of, and use, the existing
> FDPIC_FUNCPTRS value. I suspect very few such binaries (FDPIC but
> compatible with being loaded by the normal ELF loader) exist at this
> point, though, and the need for this could be eliminated if the normal
> ELF loader also detected the FDPIC ELF headers bits and set the
> FDPIC_FUNCPTRS personality accordingly.
>
> Rich
