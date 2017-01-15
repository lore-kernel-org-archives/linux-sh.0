From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 15 Jan 2017 12:21:49 +0000
Subject: Resolving glibc namespace conflicts with R0..Rn
Message-Id: <e35765d0-5daa-7289-4d35-0b416013494c@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

We're currently running into a name conflict issue when building Firefox on sh4
with the R0..Rn register names. Apparently, there have been several packages which
were affected by this issue with the result that glibc upstream decided to resolve
this issue on ARM by renaming Rn to REG_Rn [1]. The discussion in the Firefox bugtracker
regarding the issue can be followed here [2].

Would it be possible to make this change in glibc on SH as well?

Apparently, the only big user which would suffer breakage would be gdb but since
there is currently not official SH support in gdb anyway, I think we're good
to go.

Adrian

> [1] https://sourceware.org/ml/libc-ports/2011-12/msg00032.html
> [2] https://bugzilla.mozilla.org/show_bug.cgi?id29194#c15

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
