From: Simon Horman <horms@verge.net.au>
Date: Tue, 25 Nov 2014 00:23:44 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: koelsch dts: Drop console= bootargs parameter
Message-Id: <20141125002344.GD5656@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
 <1414592918-25138-4-git-send-email-geert+renesas@glider.be>
 <42870768.kOpZNjp1qs@avalon>
 <CAMuHMdUOX845FFaNkEan9c+fRrsSk4q0gXUeknTn-MK5JAYWGg@mail.gmail.com>
 <20141114030235.GA28000@verge.net.au>
 <CAMuHMdU-oWC8aTUK-Oxf72XxzEYUnn5O25L-hWi1dEQpqe+-gg@mail.gmail.com>
In-Reply-To: <CAMuHMdU-oWC8aTUK-Oxf72XxzEYUnn5O25L-hWi1dEQpqe+-gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Nov 14, 2014 at 09:04:29AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Nov 14, 2014 at 4:02 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Oct 30, 2014 at 12:03:22PM +0100, Geert Uytterhoeven wrote:
> >> On Thu, Oct 30, 2014 at 11:44 AM, Laurent Pinchart
> >> <laurent.pinchart@ideasonboard.com> wrote:
> >> > On Wednesday 29 October 2014 15:28:38 Geert Uytterhoeven wrote:
> >> >> Since commit 595c6a4bb77f0096 ("ARM: shmobile: koelsch: Remove legacy C
> >> >> board code"), koelsch is restricted to booting from DT, so
> >> >> chosen/stdout-path is always used, and we can drop the "console="
> >> >> parameter from chosen/bootargs.
> >> >
> >> > I'm curious, how is the baud rate now selected ?
> >>
> >> >From an earlier response for kzm9d:
> >>
> >> "I forgot emev is the only supported SoC not using sh-sci.
> >>  drivers/tty/serial/sh-sci.c:serial_console_setup() defaults to 115200 baud,
> >>  while serial8250_console_setup() defaults to 9600 baud."
> >
> > Hi Geert,
> >
> > while backporting this and similar changes for other boards
> > to v3.14/LTSI-3.14 I noticed that koelsch, alt and ape6evm-reference
> > come up without a console. Which is not ideal.
> >
> > I am wondering if you have any thoughts on why this may occur.
> > My wild stab in the dark is some interaction with PM.
> >
> > For reference my backport is the backport/v3.14.23/snapshot2.wip1 tag in my
> > renesas-backports tree. At the very top it includes reversions of the
> > backports of the troublesome patches.
> 
> You're missing the core changes that enabled this feature, which appeared in
> v3.17, cfr. the two commits below. The third one is a fix, but as no one checked
> the return value, you can drop if it you want.
> 
> If it still doesn't work afterwards, just let me know, and I'll dive into it.

Thanks Geert,

that was very helpful to me. With the patches you suggested and
one more noted below, which I found after a bit of digging, the
problem appears to be resolved.

I plan to push the result as backport/v3.14.23/snapshot2.wip2
in the not to distant future.

> commit 3482f2c52b77bf6596e24aae82e204a0603eba66
> Author: Grant Likely <grant.likely@linaro.org>
> Date:   Thu Mar 27 17:18:55 2014 -0700
> 
>     of: Create of_console_check() for selecting a console specified in /chosen
> 
>     The devicetree has a binding for specifying the console device in the
>     /chosen node, but the kernel doesn't use it consistently. This change
>     adds an API for testing if a device node is a console, and adds a
>     preferred console entry if it is.
> 
>     At the same time this patch removes the of_device_is_stdout_path() API
>     since it is unused.
> 
>     Signed-off-by: Grant Likely <grant.likely@linaro.org>
>     Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> 
> commit a208ffd251d08ed7ba6bdf3ae1e423373fb12d3d
> Author: Grant Likely <grant.likely@linaro.org>
> Date:   Thu Mar 27 18:29:46 2014 -0700
> 
>     of: Enable console on serial ports specified by /chosen/stdout-path
> 
>     If the devicetree specifies a serial port as a stdout device, then the
>     kernel can use it as the default console if nothing else was selected on
>     the command line. For any serial port that uses the uart_add_one_port()
>     feature, the uart_add_one_port() has all the information needed to
>     automatically enable the console device, which is what this patch does.
> 
>     With this change applied, a device tree platform can be booted without
>     any console= parameters on the command line and the kernel will still be
>     able to determine its console.
> 
>     Tested on QEMU Versatile model and i.MX
> 
>     Signed-off-by: Grant Likely <grant.likely@linaro.org>
>     Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> 
> commit 5f74d8b7b8546255db6af45b017e9cbb18aed609
> Author: Brian Norris <computersforpeace@gmail.com>
> Date:   Wed Sep 3 11:06:43 2014 -0700
> 
>     of: correct of_console_check()'s return value
> 
>     The comments above of_console_check() say that it will return TRUE if it
>     registers a preferred console, but add_preferred_console() uses a
>     0-equals-success convention, so this leaves of_console_check() with an
>     inconsistent policy for its return values.
> 
>     Fortunately, nobody was actually checking the return value of
>     of_console_check(), so this isn't significant at the moment.
> 
>     But let's match the comments, so we're doing what we say.
> 
>     Fixes: 3482f2c52b77 ('of: Create of_console_check() for selecting a console
>     Signed-off-by: Brian Norris <computersforpeace@gmail.com>
>     Signed-off-by: Grant Likely <grant.likely@linaro.org>
> 

commit 676e1b2fcd9dbb47a59baac13d089621d22c68b8
Author: Grant Likely <grant.likely@linaro.org>
Date:   Thu Mar 27 17:11:23 2014 -0700

    of: Add support for ePAPR "stdout-path" property
    
    ePAPR 1.1 defines the "stdout-path" property for specifying the console
    device, but Linux currently only handles the older "linux,stdout-path"
    property. This patch adds parsing for the new property name.
    
    Signed-off-by: Grant Likely <grant.likely@linaro.org>
