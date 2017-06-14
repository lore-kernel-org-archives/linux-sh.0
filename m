From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 14 Jun 2017 13:48:21 +0000
Subject: Re: QEMU serial still broken in -rc1.
Message-Id: <20170614134820.GG16230@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
In-Reply-To: <cdec4797-afe1-11f8-f926-fb5d356da625@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rob!

On Sun, May 14, 2017 at 09:46:07PM -0500, Rob Landley wrote:
> I refer to the previous thread, which is still the case:
> 
> http://www.spinics.net/lists/linux-sh/msg51190.html
> 
> I poked at QEMU's internals to see if there was an easy way to fiddle
> with stuff, but A) ttySC1 appears to be the only serial type the board
> emulates, B) the ttySC0 instance is broken, dunno why.

I gave it a try myself now and I can't get the emulated machine to
boot or show any output over the serial console.

It hangs here:

root@nofan:~/sh4-system> qemu-system-sh4 -M r2d -m 1000M -drive file=sh4-system.img,format=qcow2 -nographic -append "root=/dev/sda1 rw console=ttySC0 earlyprintk=sh-sci.1" -kernel vmlinux-3.18.0-trunk-sh7751r 
long read to SH7750_WCR1_A7 (0x000000001f800008) ignored
long read to SH7750_WCR2_A7 (0x000000001f80000c) ignored
long read to SH7750_WCR3_A7 (0x000000001f800010) ignored
long read to SH7750_MCR_A7 (0x000000001f800014) ignored
long read to SH7750_MCR_A7 (0x000000001f800014) ignored

Any ideas?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
