From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 27 Jul 2009 02:40:18 +0000
Subject: Re: Problem with current kernel and old sh3 machines
Message-Id: <aec7e5c30907261940p4c488275sa327e416c95cdfef@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
In-Reply-To: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael!

On Fri, Jul 24, 2009 at 11:49 PM, Rafael Ignacio
Zurita<rizurita@yahoo.com> wrote:
> On Fri, Jul 24, 2009 at 12:30:06PM +0900, Magnus Damm wrote:
>> Sorry about the delay. If you still have time, please let me know
>> which hardware platform you want to focus on.
>
> No problem. I want to get early printk in sh3 sh7709 (sh770x) + hd64461
> cchip, because I would like to work/test with both: Jornada 680 and Palmtop
> 660lx.

Step 1: Figure out which serial port to use.

First of all I need to know which serial port that is being used on
your hardware platform(s). In most cases there's a
"console=ttySCX,115200" in CONFIG_CMDLINE for the board defconfig (X
is used to point out the serial port), but the file hp6xx_defconfig
does not have CONFIG_CMDLINE_BOOL set so CONFIG_CMDLINE happens to be
empty.

So please figure out which serial port(s) that are used by your
hardware platform(s). sh7709 has 3 serial ports, your job is to figure
out which port your board(s) are using.

The easiest way to do so is to read some hardware specs, and if you
can't find any then just look at /proc/interrupts on a working kernel
and compare the IRQ number for the serial port with the IRQ numbers in
sci_platform_data[] in your cpu setup file (setup-sh770x.c in this
case). What we want to get is the .mapbase value for the serial port
we should use for early printk.

Please do this for both hardware platforms and email the .mapbase
values to the list.

> I tried to patch arch/sh/kernel/cpu/sh3/setup-sh770x.c
> like you did with sh772 in http://patchwork.kernel.org/patch/23714/ ,
> but when I try to boot with "earlyprintk=sh-sci.0" or "earlyprintk=sh-sci.1"
> the machine resets after a while without serial output.

Aha, thanks for trying that out. That code was my attempt to unify the
early printk code with the serial driver. We're not 100% there yet. =)
I think the in-tree version of early prink should be enough for our
needs at this point though.

Step 2: Get early prink working on an old known working kernel.

When you know the result from Step 1 then edit
arch/sh/kernel/early_printk.c and change both instances of
CONFIG_EARLY_SCIF_CONSOLE_PORT to the .mapbase value. You may also
need to change scif_port.type depending on if your port is a SCI, SCIF
or SCIFA.

Then edit your kernel config and make sure your command line includes
"earlyprintk=serial".

Look at the defconfig for migor_defconfig - both wrt CONFIG_CMDLINE
and early printk config options - CONFIG_EARLY_SCIF_CONSOLE=y +
CONFIG_EARLY_PRINTK=y.

That should be it! Depending on your boot loader you may also need to
comment out code in early_printk.c.

Step 3: Test the early printk code on the old kernel.

Add a BUG() or panic() or printk() with an endless loop somewhere
early. Inside sh770x_devices_setup() may be a good place. Hanging the
kernel there should be early enough for not getting any output without
early printk, but will give you output when early printk is enabled.

You probably want to boot the kernel without mouting any root
partition to avoid checking disks if you need to boot many times....

Step 4: Get early printk working on the broken kernel

This should be farily easy if you've managed to get Step 2 + 3 working. =)

> Anyway, I don't understand well what I should do, so I decided to wait
> you.
>
> Again, thanks in advance if you can help me with this.

Please try out the steps above. Let me know how it works out for you!
I would be happy to give you more detailed information if you get
stuck.

Cheers,

/ magnus
