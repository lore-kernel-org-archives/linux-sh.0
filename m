From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 18 Apr 2011 10:23:22 +0000
Subject: Re: Linux kernel 2.6.35 webcam issue
Message-Id: <20110418102322.GK32457@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <35FC1A56EEC91A42A0EB92079193ED8D0335279D@ASISML10.asia-idc.local>
In-Reply-To: <35FC1A56EEC91A42A0EB92079193ED8D0335279D@ASISML10.asia-idc.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 12, 2011 at 09:39:47AM +0800, Feng Yang wrote:
> Hi 
> I have trouble in load uvc(USB Video Class) driver on SH platform.
> I build kernel config option as below.
> <*>   USB Gadget Support  --->   
> <M>   USB Gadget Drivers
> <M>     USB Webcam Gadget 
> 
> #insmod /lib/modules/2.6.35/kernel/drivers/usb/gadget/g_webcam.ko
> I insert USB cable form webcam, then I get error message as below.
> The webcam brand is "Logitech C270"
> 
> ------------[ cut here ]------------
> kernel BUG at mm/slab.c:3058!
> Kernel BUG: 003e [#1]
> last sysfs file: /sys/class/usb_device/usbdev1.2/dev
> Modules linked in: g_webcam
> 
> Pid : 193, Comm:                khubd
> CPU : 0                 Not tainted  (2.6.35 #4)
> 
> PC  : 88065038 SP  : 97051dd8 SR  : 400081f1 TEA : c000f7ec
> R0  : 970032e8 R1  : 97195cc0 R2  : 0000000c R3  : 00000001
> R4  : 97001420 R5  : 000000d0 R6  : 970032e8 R7  : ffffffff
> R8  : 97001420 R9  : 9700b1a0 R10 : 000000d0 R11 : 00000000
> R12 : 970032e0 R13 : 970032f0 R14 : 00000000
> MACH: 00000010 MACL: 1bb01000 GBR : 00000000 PR  : 880653e2
> 
> Call trace:
>  [<880653e2>] 0x880653e2
>  [<8817f08a>] 0x8817f08a
>  [<8817dc8e>] 0x8817dc8e
>  [<8817dd32>] 0x8817dd32
>  [<881773a2>] 0x881773a2
>  [<88177aa4>] 0x88177aa4
>  [<88177d66>] 0x88177d66
>  [<88178f6e>] 0x88178f6e
>  [<8810d462>] 0x8810d462
>  [<8802791c>] 0x8802791c
>  [<88027622>] 0x88027622
>  [<88178790>] 0x88178790
>  [<88003e92>] 0x88003e92
>  [<880275cc>] 0x880275cc
>  [<88003e8c>] 0x88003e8c
> 
You've unfortunately not enabled debug info, so this backtrace is useless
without the corresponding System.map.

If you're able to reproduce this, you may wish to rebuild with both
CONFIG_DEBUG_INFO and CONFIG_DEBUG_BUGVERBOSE set, and post the more
detailed log.

In any event, 2.6.35 is a very old kernel, so you can save yourself a lot
of trouble by testing a new kernel and seeing if the problem persists --
backporting fixes is always less work than debugging something that has
already been debugged!
