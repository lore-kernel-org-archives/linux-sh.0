From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Sep 2013 16:47:48 +0000
Subject: Re: [PATCH 3/3 v4] ARM: shmobile: bockw: add USB Function support
Message-Id: <522DFBB4.8040402@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v2g6psd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 09/09/2013 11:50 AM, Magnus Damm wrote:

>>> [CC Laurent]

>>>>> Bock-W USB1 (CN29) can be USB Host/Func by SW98/SW99 settings.
>>>>> USB Func will be enabled if CONFIG_USB_RENESAS_USBHS_UDC[_MODULE]
>>>>> was selected on this patch

>>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>>> ---
>>>>> v3 -> v4

>>>>>    - no change

>>>>>    arch/arm/mach-shmobile/board-bockw.c |   81
>>>>> ++++++++++++++++++++++++++++++++--

>>>> Magnus, could you review this?

>>> Sure, I can try. Just to be clear though - I think I know this board
>>> and SoC as little as you do. =)

>>>>>    1 file changed, 78 insertions(+), 3 deletions(-)

>>>>> diff --git a/arch/arm/mach-shmobile/board-bockw.c
>>>>> b/arch/arm/mach-shmobile/board-bockw.c
>>>>> index 07009f5..8094803 100644
>>>>> --- a/arch/arm/mach-shmobile/board-bockw.c
>>>>> +++ b/arch/arm/mach-shmobile/board-bockw.c

>> [...]

>>>>> @@ -281,5 +356,5 @@ DT_MACHINE_START(BOCKW_DT, "bockw")
>>>>>         .init_machine   = bockw_init,
>>>>>         .init_time      = shmobile_timer_init,
>>>>>         .dt_compat      = bockw_boards_compat_dt,
>>>>> -     .init_late      = r8a7778_init_late,
>>>>> +     .init_late      = bockw_init_late,
>>>>>    MACHINE_END


>>> Morimoto-san,


>>> Thanks for your work on this. In this patch I understand that you
>>> based on Kconfig select if ehci-platform or renesas-usbhs should be
>>> used.  I wonder how well that will work together with multiplatform
>>> kernels in the future. Probably not so well. So we need to figure out
>>> how to handle this in the future.


>>> I propose that we accept this patch as-is today to enable the
>>> hardware, but we should also investigate if we for instance could let
>>> the PFC handle mutual exclusion of the hardware


>>     There is no mutual exclusion in this case -- host and device controllers
>> only compete for USB port 1, with host owning port 0 exclusively. So both
>> host and device drivers can be loaded and work concurrently.

> So there is one host-only port and another host/gadget port. The

    No, 2nd port is either host or gadget, and currently it's determined by 
the USB PHY platform data. The port is not runtime switchable.

> former seems easy enough, but I believe the latter one may be
> problematic if the host is EHCI/OHCI and gadget is renesas_usbhs.
> Regardless, unless I'm mistaken then using bind should allow us to
> assign these during run-time.

    I doubt it since we need to reconfigure the common PHY.

>>> and use bind/unbind to
>>> start/stop devices during run time. Paul Mundt and I talked about this
>>> ages ago but I'm not sure if it is actually possible with pinctrl or
>>> not. If possible would install both ehci-platform and renesas-usbhs
>>> devices in parallel and instead dynamically select one of them through
>>> sysfs.


>>> Laurent, do you think it is possible to use pinctrl for mutual
>>> exclusion control in the drivers somehow? Basically, if the requested
>>> pins are already in use then the conflicting driver instance should
>>> error out.


>>     I would think it's the natural thing to do, yet currently device core
>> just ignores the pin conflict IIRC.

> Oh, well if that's the case then someone needs to fix that. =)

    I also maybe behind the reality on this one, need to double check.

>>> We also want to have DT bindings for USB drivers. Morimoto-san, can
>>> you please work on adding USB support to Bock-W DT reference?


>>     DT bindings for EHCI/OHCI hosts are simply not possible due to using
>> procedural platform data. The same seems true for USB device controller.
>> Thus the only thing convertible to DT is USB common PHY and it's still on my
>> agenda.

> But this must be a driver design issue, no?

    No, it's a question of using the dedicated drivers instead of generic 
[eo]hci-platform drivers. We then would do things we're doing in the 
platform-specific methods in the drivers themselves and DT binding should pose 
no issues.

> So if the driver could be
> reworked then I suspect it could be treated as any other DT device. Of
> course, this may be quite difficult in practice..

    Impossible even with the current drivers. Probably using these drivers was 
a bad move from the start viewed from the DT POV.

> Cheers,

> / magnus

WBR, Sergei

