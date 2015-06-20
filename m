From: Rich Felker <dalias@libc.org>
Date: Sat, 20 Jun 2015 18:06:44 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <20150620180644.GY1173@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 19, 2015 at 03:09:12AM -0400, Rich Felker wrote:
> Presently the SH version of the sigcontext structure, and thus
> mcontext_t/ucontext_t, varies in a way that mismatches and breaks ABI.
> On the kernel side, whether it has space for FPU registers (or worse,
> uses a completely different SH5 layout) depends on whether the kernel
> was built for hardware with or without FPU (or for pre-SH5 vs SH5). On
> the userspace side, glibc always uses the pre-SH5 layout, but whether
> it has space for FPU registers depends on whether the _userspace_
> binary was compile for FPU or no-FPU. This can and does mismatch the
> kernel's definition when a no-FPU binary is being run on
> hardware/kernel with FPU, and the mismatch is particularly bad because
> the uc_sigmask member, which signal handlers can legitimately inspect,
> moves around depending on which version of the structure is in use.
> 
> I did some research and this issue goes way back, to before the
> beginning of the kernel git repository.

From further research (glibc repo), it looks like glibc has had
separate definitions of ucontext for sh3/sh4 ever since it supported
them, and apparently never considered what happens if you run sh3
binaries on a sh4 kernel/hardware. But I don't have pre-git history so
maybe there are ancient details I'm missing.

From one copy of the davej history repo I found, the FPU registers
seem to have been added in 2.3.99pre4-1. Before that, signal.c had no
support at all for saving/restoring FPU registers, as far as I can
tell, despite entry.S handling them for context switches on sh4. At
the same time the FPU registers were added, the layout of the base
register set was also changed; sp was moved from sc_sp in its own
discontiguous location to sc_regs[15].

So there's a lot of historical mess and breakage here, but sh3
binaries have been running with a stable (albeit wrong, IMO)
definition of ucontext_t/mcontext_t/sigcontext for around 14 years
now (as long as they only run on sh3 hardware, not sh4). So I'm a bit
hesitant to consider this something that could be changed with no path
for compatibility.

What would be the right approach with personality? Is there any way
for the kernel to automatically set a personality based on the ELF
headers? There are two userspace ABIs anyway (fpu ABI, only available
on sh4 or sh2a, and nofpu ABI, available everywhere in theory but
presently broken if you run it on hardware with fpu) and they can be
distinguished by the e_flags ELF header. Alternatively, userspace
could be responsible for calling SYS_personality with the right value
in start code moving forward.

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
