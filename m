From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 26 Sep 2017 12:36:42 +0000
Subject: Re: Bug report: kernel BUG at arch/sh/kernel/dwarf.c:547!
Message-Id: <375a83b2-3b67-5c5c-9a4e-a7001bceae00@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20170926142902.36e9539e@windsurf.lan>
In-Reply-To: <20170926142902.36e9539e@windsurf.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Thomas!

On 09/26/2017 02:29 PM, Thomas Petazzoni wrote:
> I'm using Linux 4.13 on a big endian SH4A system,

Wow, that's the first time I hear someone use SuperH in Big-Endian mode.

May I ask what kind of hardware you are using? I'm still looking for
new/used SH4 boards to add additional buildd resources in Debian.

> a kernel panic (for example because there is no root filesystem
> available), I get "kernel BUG at arch/sh/kernel/dwarf.c:547!". It seems
> like the DWARF-reading logic in arch/sh/kernel/dwarf.c doesn't support
> some recent DWARF information emitted by gcc. My toolchain uses gcc
> 6.4.0. Have you already encountered this problem?
> 
> You'll find below the full kernel panic log. You'll also notice that
> the layout of the kernel panic message is really weird, with many
> newlines all over the place, which probably is another bug.
I think it might be a better idea to report this issue to the kernel
bugzilla [1] so your bug report doesn't get lost. SuperH can now be
selected as the target architecture, too.

Adrian

> [1] https://bugzilla.kernel.org/

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
