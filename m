From: Rich Felker <dalias@libc.org>
Date: Tue, 15 Sep 2015 04:11:24 +0000
Subject: Re: [PATCH v2] arch/sh: provide unified syscall trap compatible with all SH models
Message-Id: <20150915041124.GJ17773@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150825030338.GA14922@brightrain.aerifal.cx>
 <20150825212311.GM32742@brightrain.aerifal.cx>
In-Reply-To: <20150825212311.GM32742@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, shumpei.kawasaki@swhwc.com, Yoshinori Sato <ysato@users.sourceforge.jp>, jeff@uclinux.org, Geert Uytterhoeven <geert@linux-m68k.org>

Ping?

On Tue, Aug 25, 2015 at 05:23:11PM -0400, Rich Felker wrote:
> From: Rich Felker <dalias@libc.org>
> 
> Historically SH-2 Linux (and originally uClinux) used a syscall
> calling convention incompatible with the established SH-3/4 Linux ABI.
> This choice was made because the trap range used by the existing ABI,
> 0x10-0x17, overlaps with the hardware exception/interrupt trap range
> reserved by SH-2, and in particular, with the SH-2A divide-by-zero and
> division-overflow exceptions.
> 
> Despite the documented syscall convention using the low bits of the
> trap number to signal the number of arguments the kernel should
> expect, no version of the kernel has ever used this information, nor
> is it useful; all of the registers need to be saved anyway. Therefore,
> it is possible to pick a new trap number, 0x1f, that is both supported
> by all existing SH-3/4 kernels and unassigned as a hardware trap in
> the SH-2 range. This makes it possible to produce SH-2 application
> binaries that are forwards-compatible with running on SH-3/4 kernels
> and to treat SH as a unified platform with varying ISA support levels
> rather than multiple gratuitously-incompatible platforms.
> 
> This patch adjusts the range checking SH-2 and SH-2A kernels make for
> the syscall trap to accept the range 0x1f-0x2f rather than just
> 0x20-0x2f. As a result, trap 0x1f now acts as a syscall for all SH
> models.
> 
> Signed-off-by: Rich Felker <dalias@libc.org>
> 
> ---
> 
> The original proposal for using 0x1f as a unified syscall trap was
> reviewed by Jeff Dionne, Yoshinori Sato, and Shumpei Kawasaki for
> conflicts with existing trap number assignments, and none were found.
> I introduced this proposal as a way to add SH-2 support to musl libc
> in a forwards-compatible way, treating SH as a unified architecture,
> with the particular intent of supporting the Open Processor
> Foundation's J2 Core (SH-2 ISA plus some extensions) and providing a
> smooth upgrade path to the future J4 Core (SH-4 equivalent) and other
> full-fledged SH platforms with MMU.
> 
> There is also some interest in having glibc's SH port support SH-2/J2,
> which is more practical with a common syscall ABI; whether this will
> actually happen remains uncertain.
> 
> Version 2 of the patch addresses issues raised by Geert Uytterhoeven
> with the changes to comments in entry-common.S.
> 
> Rich
> 
> 
> 
> diff -urp ../linux-4.2-rc6.orig/arch/sh/kernel/cpu/sh2/entry.S ./arch/sh/kernel/cpu/sh2/entry.S
> --- ../linux-4.2-rc6.orig/arch/sh/kernel/cpu/sh2/entry.S	2015-08-09 19:54:30.000000000 +0000
> +++ ./arch/sh/kernel/cpu/sh2/entry.S	2015-08-24 03:23:34.159387924 +0000
> @@ -144,9 +144,9 @@ ENTRY(exception_handler)
>  	mov	#64,r8
>  	cmp/hs	r8,r9
>  	bt	interrupt_entry	! vec >= 64 is interrupt
> -	mov	#32,r8
> +	mov	#31,r8
>  	cmp/hs	r8,r9
> -	bt	trap_entry	! 64 > vec >= 32  is trap
> +	bt	trap_entry	! 64 > vec >= 31  is trap
>  
>  	mov.l	4f,r8
>  	mov	r9,r4
> @@ -178,9 +178,9 @@ interrupt_entry:
>  
>  trap_entry:
>  	mov	#0x30,r8
> -	cmp/ge	r8,r9		! vector 0x20-0x2f is systemcall
> +	cmp/ge	r8,r9		! vector 0x1f-0x2f is systemcall
>  	bt	1f
> -	add	#-0x10,r9	! convert SH2 to SH3/4 ABI
> +	mov     #0x1f,r9	! convert to unified SH2/3/4 trap number
>  1:	
>  	shll2	r9			! TRA
>  	bra	system_call	! jump common systemcall entry
> diff -urp ../linux-4.2-rc6.orig/arch/sh/kernel/cpu/sh2a/entry.S ./arch/sh/kernel/cpu/sh2a/entry.S
> --- ../linux-4.2-rc6.orig/arch/sh/kernel/cpu/sh2a/entry.S	2015-08-09 19:54:30.000000000 +0000
> +++ ./arch/sh/kernel/cpu/sh2a/entry.S	2015-08-24 03:23:58.849386418 +0000
> @@ -109,9 +109,9 @@ ENTRY(exception_handler)
>  	mov	#64,r8
>  	cmp/hs	r8,r9
>  	bt	interrupt_entry	! vec >= 64 is interrupt
> -	mov	#32,r8
> +	mov	#31,r8
>  	cmp/hs	r8,r9
> -	bt	trap_entry	! 64 > vec >= 32  is trap
> +	bt	trap_entry	! 64 > vec >= 31  is trap
>  
>  	mov.l	4f,r8
>  	mov	r9,r4
> @@ -143,9 +143,9 @@ interrupt_entry:
>  
>  trap_entry:
>  	mov	#0x30,r8
> -	cmp/ge	r8,r9		! vector 0x20-0x2f is systemcall
> +	cmp/ge	r8,r9		! vector 0x1f-0x2f is systemcall
>  	bt	1f
> -	add	#-0x10,r9	! convert SH2 to SH3/4 ABI
> +	mov     #0x1f,r9	! convert to unified SH2/3/4 trap number
>  1:	
>  	shll2	r9			! TRA
>  	bra	system_call	! jump common systemcall entry
> diff -urp ../linux-4.2-rc6.orig/arch/sh/kernel/entry-common.S ./arch/sh/kernel/entry-common.S
> --- ../linux-4.2-rc6.orig/arch/sh/kernel/entry-common.S	2015-08-09 19:54:30.000000000 +0000
> +++ ./arch/sh/kernel/entry-common.S	2015-08-25 21:08:15.835463227 +0000
> @@ -268,20 +268,29 @@ debug_trap:
>   *	Syscall #: R3
>   *	Arguments #0 to #3: R4--R7
>   *	Arguments #4 to #6: R0, R1, R2
> - *	TRA: (number of arguments + ABI revision) x 4
> + *	TRA: See following table.
>   *
> - * This code also handles delegating other traps to the BIOS/gdb stub
> - * according to:
> - *
> - * Trap number
>   * (TRA>>2)	Purpose
>   * --------	-------
>   * 0x00-0x0f	original SH-3/4 syscall ABI (not in general use).
>   * 0x10-0x1f	general SH-3/4 syscall ABI.
> - * 0x20-0x2f	syscall ABI for SH-2 parts.
> + *      0x1f	unified SH-2/3/4 syscall ABI (preferred).
> + * 0x20-0x2f	original SH-2 syscall ABI.
>   * 0x30-0x3f	debug traps used by the kernel.
>   * 0x40-0xff	Not supported by all parts, so left unhandled.
>   *
> + * For making system calls, any trap number in the range for the
> + * given cpu model may be used, but the unified trap number 0x1f is
> + * preferred for compatibility with all models.
> + *
> + * The low bits of the trap number were once documented as matching
> + * the number of arguments, but they were never actually used as such
> + * by the kernel. SH-2 originally used its own separate trap range
> + * because several hardware exceptions fell in the range used for the
> + * SH-3/4 syscall ABI.
> + *
> + * This code also handles delegating other traps to the BIOS/gdb stub.
> + *
>   * Note: When we're first called, the TRA value must be shifted
>   * right 2 bits in order to get the value that was used as the "trapa"
>   * argument.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
