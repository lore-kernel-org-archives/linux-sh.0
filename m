From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Dec 2015 03:53:12 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: gose: Add GPIO keys and leds to DT
Message-Id: <CANqRtoRtv--W-yVcAQYbHCz0-=AZqAy0jenBzQfEjfAVyJWP3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447885235-17858-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447885235-17858-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Thu, Nov 19, 2015 at 7:20 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi,
>
> this short series adds GPIO keys and leds to the device tree
> of the r8a7793 based Gose board.
>
> It uses the makes use of the recently addition of GPIO devices
> to the device tree of the r8a7793. Thanks Magnus!
>
> I have booted a system with these changes and verified that the
> relevant entries appear to be present in sysfs.
>
> I have not tested button press events or illumination of the leds
> as I do not currently have physical access to a Gose board.
>
> Based on renesas-devel-20151118-v4.4-rc1
>
> Simon Horman (2):
>   ARM: shmobile: gose: Add GPIO keys to DT
>   ARM: shmobile: gose: Add GPIO leds to DT
>
>  arch/arm/boot/dts/r8a7793-gose.dts | 98 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)

Thanks a lot for these patches! Very useful as basic a test
environment for the r8a7793 GPIO device nodes.

So I've now managed to test the GPIO keys and LED devices on a
physical Gose board. The LED6 -> LED 8 entries will be lit as expected
by controlling brightness in /sys/class/leds/. The GPIO keys
associated with buttons SW30 to SW36 and the dip switch SW2 all
generate interrupts in /proc/interrupts on key press or dip switch
change. All good!

Please queue up these changes. Feel free to add:

Tested-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus
