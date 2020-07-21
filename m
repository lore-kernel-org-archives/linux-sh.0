From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 21 Jul 2020 18:59:25 +0000
Subject: Adding support for SECCOMP_FILTER
Message-Id: <32f7f7a2-a186-a3cc-0d03-e3380c0d21fc@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello!

I recently discovered that the kernel supports seccomp on Linux as support
was added in 2.6.27 [1].

I consequently added SH support to libseccomp [2], only to discover that we
are missing the SECCOMP_FILTER feature. Looking at the changes for PA-RISC [3]
and RISC-V [4], the necessary changes in the kernel seem to be rather modest.

Would anyone be willing to help me to implement SECCOMP_FILTER for SH? From what
I can see, we just need to implement the part to add syscall filtering.

Adrian

> [1] https://github.com/torvalds/linux/commit/c4637d475170ca0d99973efd07df727012db6cd1
> [2] https://github.com/seccomp/libseccomp/pull/271
> [3] https://github.com/torvalds/linux/commit/910cd32e552ea09caa89cdbe328e468979b030dd
> [4] https://github.com/torvalds/linux/commit/5340627e3fe08030988bdda46dd86cd5d5fb7517

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
