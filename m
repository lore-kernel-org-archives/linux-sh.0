From: Rich Felker <dalias@libc.org>
Date: Wed, 25 Apr 2018 18:30:34 +0000
Subject: Re: Board support for NextVoD - pdk7105
Message-Id: <20180425183034.GF3094@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
In-Reply-To: <406f18f4-33df-04f8-919b-5f431dd2229b@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 03, 2016 at 11:59:27AM +0200, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> I'm currently playing around with a NextVoD box from Taiwan which is
> a VoD system based on the ST40 SoC by ST Microelectronics:
> 
> root@nextvod01:~# cat /proc/cpuinfo
> machine		: pdk7105
> processor	: 0
> cpu family	: sh4
> cpu variant	: st40-300
> cpu type	: STx7105
> cut		: 3.x
> cpu flags	: fpu icbi synco fpchg
> cache type	: split (harvard)
> icache size	: 32KiB (2-way)
> dcache size	: 32KiB (2-way)
> address sizes	: 32 bits physical
> bogomips	: 448.51
> root@nextvod01:~#
> 
> Attaching the output from dmesg and the current kernel config.gz.
> 
> The machine is currently running a rather old kernel which I would like
> to update, however I'm not sure whether the necessary patches have been
> upstreamed. There is a git repository available which has 2.6.32 kernel
> with the necessary patches [1].
> 
> Do you think we could get this merged into the normal SH kernel?

I've got my replacement NextVoD setup more properly now and ready for
development work. Is this the source for the kernel you're using and
shipped with it? The repo does not seem to be based off upstream
kernel git at all, but rather a new repo starting with some
already-modified 2.6.32 tree as the initial commit.

If this is the right starting point, I'll pull the initial commit from
it and start diffing it against STlinux 2.4's "2.6.32" (which is
itself already modified and probably contains a lot of prereqs; src is
available as srpm at http://archive.stlinux.com/stlinux/2.4/SRPMS/),
and see if I can determine what the actual changes are.

This could be a good direction for future of arch/sh -- presumably all
the ST SoCs have a lot in common and could probably be a good first
target for supporting with device tree rather than legacy-style board
files full of platform devices.

Rich
