From: Rich Felker <dalias@libc.org>
Date: Tue, 26 Apr 2016 01:14:31 +0000
Subject: [PATCH] sh: make sigcontext definition consistent across fpu/nofpu models
Message-Id: <20160426011431.GA3752@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Up until now, the SH version of the sigcontext structure, and thus
mcontext_t/ucontext_t, varied depending on the cpu model the kernel
was built to run on. SH-4 (including SH-4A) and SH-2A used the form
with space for FPU registers, and everything else used a form that
omitted them.

From a userspace perspective, however, the structure layout must be
fixed for a given ABI. Traditionally glibc and uClibc used the form
with space for FPU registers only when __SH4__ (which implies FPU;
__SH4_NOFPU__ is the predefined macro for SH-4 but with no-FPU ABI)
was defined. As a result:

- SH-4 no-FPU programs never matched kernel sigcontext.

- SH-3 programs did not match kernel sigcontext if run on SH-4,
  despite an apparent intent that they be compatible.

- SH-2 and SH-2A programs (using uClibc) did not match kernel
  sigcontext if run on SH-2A.

The mismatch might seem inconsequential because it occurs at the end
of the sigcontext structure, but sigcontext is embedded as uc_mcontext
in ucontext_t, where it is followed by uc_sigmask, an important member
for signal handlers to have access to. In particular, access to
uc_sigmask is necessary for a correct implementation of thread
cancellation.

It would be possible to retain support for both sigcontext ABIs via a
personality mechanism, but since many configurations were already
broken and nobody noticed, and since there are very few if any users
of legacy no-FPU models anymore, I have opted to just remove the
variation and always include space for the FPU registers in
sigcontext. This was proposed and discussed on a thread "SH sigcontext
ABI is broken" cross-posted to linux-sh, libc-alpha, and musl libc
lists in June 2015, and no objections were raised.

Signed-off-by: Rich Felker <dalias@libc.org>
---

This was discussed last year and there were no objections I'm aware
of. I plan to include this in the official patch series for J2 support
and push it in the next (4.7) merge window. Please speak now if you
have a strong reason for wanting this handled differently.

 arch/sh/include/uapi/asm/sigcontext.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sh/include/uapi/asm/sigcontext.h b/arch/sh/include/uapi/asm/sigcontext.h
index 8ce1435..faa5d08 100644
--- a/arch/sh/include/uapi/asm/sigcontext.h
+++ b/arch/sh/include/uapi/asm/sigcontext.h
@@ -25,8 +25,6 @@ struct sigcontext {
 	unsigned long sc_mach;
 	unsigned long sc_macl;
 
-#if defined(__SH4__) || defined(CONFIG_CPU_SH4) || \
-    defined(__SH2A__) || defined(CONFIG_CPU_SH2A)
 	/* FPU registers */
 	unsigned long sc_fpregs[16];
 	unsigned long sc_xfpregs[16];
@@ -34,7 +32,6 @@ struct sigcontext {
 	unsigned int sc_fpul;
 	unsigned int sc_ownedfp;
 #endif
-#endif
 };
 
 #endif /* __ASM_SH_SIGCONTEXT_H */
-- 
2.8.1

