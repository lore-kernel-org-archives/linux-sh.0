From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 11 Jun 2019 13:12:31 +0000
Subject: Re: Linux SH kernel currently broken on qemu-system
Message-Id: <434a052f-6bfa-5fb3-8545-4bd9e3a30c63@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <e7855beb-fbf6-8f67-140f-21820a0fe4af@physik.fu-berlin.de>
In-Reply-To: <e7855beb-fbf6-8f67-140f-21820a0fe4af@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

On 6/10/19 3:36 PM, John Paul Adrian Glaubitz wrote:
> Booting the Linux SH kernel in qemu-system currently doesn't work, the screen
> just stays black. Previously, the kernel suffered another regression where it
> booted but crashed very early.
Michael Karcher found out that the second issue is that the kernel is too big and
overwrites the decompression code while being uncompressed.

Raising the the value for CONFIG_BOOT_LINK_OFFSET fixes the problem and lets the
kernel boot but we still have the problem that qemu probably needs to be adjusted
in order to accommodate for the larger kernel, see [1].

Any suggestions how to resolve this problem?

Adrian

> [1] https://github.com/qemu/qemu/blob/master/hw/sh4/r2d.c#L55

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
