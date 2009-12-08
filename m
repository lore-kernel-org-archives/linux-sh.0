From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 08 Dec 2009 08:18:53 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091208081853.GA25932@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 08, 2009 at 02:01:26PM +0900, yoshii.takashi@renesas.com wrote:
> Paul, thank you for your comments.
> 
> > But this breaks the entire boot ABI, and probably only for the reason ...
> Well, it is not clear because the ABI is uncertain. (I mean, I think so:)
> If you are saying ABI is important, I agree with you, and I will postpone the
> patch. And we should refrain from changing ABI related thing until the ABI
> become clear and fixed.
> 
I wasn't aware there was any ambiguity with the boot ABI, only that
certain boot loaders failed to set up the argument page properly. This is
something that was cloned from x86 originally, so it's not exactly an
exotic feature, and any sensible boot loader has no problems supporting
it.

> Here is the boot ABI guessed from current implementation and my bad memory.
> Please give your comments. > All the developers.
> After fixed, I'd like to have this as Documentation/sh/boot.txt.
> 
Thanks for your work on this, this is certainly a good start!

> Linux/SH boot protocol
> ----------------------
> 
> == Boot procedure
> 
> 1. Initialize memory system.
>  Do BSC and SDRAM and PFC setting if needed to enable to access to main
>  memory and external peripherals. That won't be done by kernel.
> 
These days we inherit the BSC settings but the PFC settings are almost
entirely blown away by the kernel through the pinmux code. Certain
platforms (ie, romimage targets) also have their own BSC initialization.

Only the BSC settings are generally left untouched, but this will
probably change in the future as more targets move to romimage booting.
Given that most of the BSC settings in the boot loaders are just lazily
copied from one platform to another, doing it properly in the kernel is
certainly a step up.

> Name: (Mode_flag?)
> Address/size: empty_zero_page+0x18/long
> 
>  This is not a part of boot ABI.
>  In vmlinux, this field carries the value indicate 29bit/32bit.
> 
Correct, this is the 32bit boot flag. It's provided as a hint to figure
out whether the boot loader has entered from 32-bit boot or not.
Presently we don't do anything with this however.

> U-Boot:
>  (Please fill this)
> 
And this would be where the problem arises. U-Boot should be able to
handle this without issue, but it's not obvious that it does at present
(hence all of the workaround patches).

> kexec:
>  (Please fill this)
> 
In the kexec case the page is zeroed and the command line is copied in.
So, only the command line is valid.
