From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 22 Jul 2020 23:31:53 +0000
Subject: Re: Adding support for SECCOMP_FILTER
Message-Id: <ee70ba65-e2a0-ab83-dcbd-0fb0f750a93f@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <32f7f7a2-a186-a3cc-0d03-e3380c0d21fc@physik.fu-berlin.de>
In-Reply-To: <32f7f7a2-a186-a3cc-0d03-e3380c0d21fc@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 7/21/20 8:59 PM, John Paul Adrian Glaubitz wrote:
> Would anyone be willing to help me to implement SECCOMP_FILTER for SH? From what
> I can see, we just need to implement the part to add syscall filtering.

Patches have been posted by Michael Karcher now to this list.

The seccomp library code is also ready for merging, see [1].

All tests pass as expected, including the live tests (with the exception
of #51 which is broken on all 32-bit targets).

Adrian

> [1] https://github.com/glaubitz/libseccomp/tree/superh

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
