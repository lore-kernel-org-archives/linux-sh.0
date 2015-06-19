From: Rich Felker <dalias@libc.org>
Date: Fri, 19 Jun 2015 07:09:12 +0000
Subject: SH sigcontext ABI is broken
Message-Id: <20150619070912.GA15025@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Presently the SH version of the sigcontext structure, and thus
mcontext_t/ucontext_t, varies in a way that mismatches and breaks ABI.
On the kernel side, whether it has space for FPU registers (or worse,
uses a completely different SH5 layout) depends on whether the kernel
was built for hardware with or without FPU (or for pre-SH5 vs SH5). On
the userspace side, glibc always uses the pre-SH5 layout, but whether
it has space for FPU registers depends on whether the _userspace_
binary was compile for FPU or no-FPU. This can and does mismatch the
kernel's definition when a no-FPU binary is being run on
hardware/kernel with FPU, and the mismatch is particularly bad because
the uc_sigmask member, which signal handlers can legitimately inspect,
moves around depending on which version of the structure is in use.

I did some research and this issue goes way back, to before the
beginning of the kernel git repository.

I see two possible ways forward. The complex but "compatible" (if
there's even such a thing as "compatible" with this mess) is
introducing new personalities for hardfloat vs softfloat sigcontext
ABIs, and having the kernel generate the proper layout for the
personality in use. The way I would prefer is just getting rid of the
#ifdefs around the fpu registers and always including storage for them
in the sigcontext, regardless of whether the machine has FPU. This
would be an ABI "change" in some sense for no-FPU environments, but
being that the ABI is already broken depending on which kernel you're
running, and nobody seems to have even noticed or cared up til now, I
think it's justified.

The SH5 layout is another matter and it's not clear to me whether SH5
can even run 32-bit binaries or whether it's essentially a completely
different arch -- I've never worked with it.

Rich
