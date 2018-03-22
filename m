From: Simon Marchi <simon.marchi@polymtl.ca>
Date: Thu, 22 Mar 2018 11:37:06 +0000
Subject: Re: Moving forward with gdb sh native support?
Message-Id: <3181a3f0c3af46ab45378feafbe627d7@polymtl.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <20180322013659.GA8118@brightrain.aerifal.cx>
In-Reply-To: <20180322013659.GA8118@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 2018-03-21 21:36, Rich Felker wrote:
> I've recently gotten a chance to get back into gdb support for the sh
> architecture, and have a series of related patches I'm going to be
> submitting upstream soon. The ones that aren't specific to
> SH2/J2/nommu stuff are adding support for software single-step (the
> hardware single-step assumed in the current linux-sh-low does not seem
> to be supported, as least not by Linux, on the vast majority of real
> and emulated hardware) and some minor bugfix prerequisites for that.
> Currently my changes here only cover gdbserver since there's no
> upstream sh-native support in gdb.
> 
> In conjunction with this I began looking again at the old sh native
> patches, which Adrian Glaubitz has been maintaining for the Debian
> side here:
> 
> https://github.com/glaubitz/binutils-gdb/commits/linux-sh
> 
> Having just looked at the gdbserver-side code for linux-sh, it looks
> like there's a nontrivial amount of code duplication, and like there
> will be even more if I copy my branch decoding (sh_get_next_pcs) code
> for single-step over.
> 
> Is this how it's supposed to be, or is there a recommended way to
> refactor it to share code between gdb and gdbserver? If so, does it
> make sense to go forward with the existing patches for sh native and
> then tweak to share some things, or would it make more sense to redo
> the native support along with a heavier refactoring?

Hi Rich,

Historically there has been a lot of duplication (and there still is) 
between GDB and GDBserver, but now we try to share as much as possible.  
This helps reducing the gap in behavior when debugging natively vs 
remotely, and helps for maintenance (fixing a bug in common code should 
fix it for both).  the gdb/arch directory contains architecture-specific 
files meant to be shared.  The code should be so that there is not 
"#ifdef GDBSERVER".  Code that should be shared between GDB and 
GDBserver but is not arch-specific goes in gdb/common.

IMO, it would make more sense to submit patches as you intend the code 
to be in the end, rather than submitting the non-shared version and 
fixing it after.

Simon
