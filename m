From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Mar 2010 03:54:25 +0000
Subject: Re: r8a66597-hcd panics when a USB device is removed from an attached hub
Message-Id: <20100315035425.GB14501@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F017F26D4B469@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F017F26D4B469@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

(Adding linux-usb to the Cc..)

On Fri, Mar 12, 2010 at 02:30:01PM +0100, Pietrek, Markus wrote:
> when a USB hub is attached to the r8a66597-hcd on the SH7723 and a
> device (e.g. mass-storage) is removed from that hub, it's likely that a
> kernel panic follows.
> 
> The reason is that the r8a66597-hcd is being polled in
> r8a66597_hub_status_data() by core/hcd.c:usb_hcd_poll_rh_status() and
> will eventually call free_usb_address() when a device change has
> occurred. Yet the r8a66597 is unaware that the hub as already
> disconnected the device with core/hub.c:usb_disconnect() and freed
> udev, so when accessing udev it crashes.
> 
> If the mass-storage device is attached directly to the r8a66597-hcd,
> the driver will receive a device detached interrupt and call
> free_usb_address() itself and so remove it from the mapping.
> 
> The question now is, how can we do it for devices connected by a hub?

Perhaps checking if dev->state = USB_STATE_NOTATTACHED and
short-circuiting the cleanup is simplest? We could obviously test
dev->udev before dev_set_drvdata(), but that's a bit ugly.

I'm not familiar enough with the USB subsystem to have any specific
suggestions with regards to what is and isn't acceptable though, or if
we're only in this mess because of some pre-existing layering violation.

> Unable to handle kernel paging request at virtual address 01000040
> pc = 881cc056
> *pde = 00000000
> Oops: 0001 [#1]
> last sysfs file: /sys/devices/platform/r8a66597_hcd.0/usb1/1-1/1-1.3/usb_device/usbdev1.3/dev
> Modules linked in:
> 
> Pid : 0, Comm:          swapper
> CPU : 0                 Not tainted  (2.6.33em0-06350-g3a5ea80-svn1025-dirty #629)
> 
> PC is at dev_set_drvdata+0x16/0x40
> PR is at free_usb_address+0xae/0xe0
> PC  : 881cc056 SP  : 8849fe4c SR  : 400081f0 TEA : 01000040
> R0  : 0000000a R1  : 01000040 R2  : 8849e000 R3  : 88003e00
> R4  : 8f5cf464 R5  : 00000000 R6  : ffffffff R7  : a4e30014
> R8  : 8f5cf464 R9  : 00000000 R10 : 00000003 R11 : 8f5ba384
> R12 : 00000008 R13 : 8f5ba0cc R14 : 00000001
> MACH: 000081c9 MACL: 21642dbc GBR : 2975f450 PR  : 8822de4e
> 
> Call trace:
>  [<8822de4e>] free_usb_address+0xae/0xe0
>  [<8822e6b8>] r8a66597_hub_status_data+0x178/0x320
>  [<88003e40>] __raw_local_save_flags+0x0/0x20
>  [<88003e00>] raw_local_irq_restore+0x0/0x40
>  [<8821d67c>] usb_hcd_poll_rh_status+0x3c/0x1c0
>  [<8821dde0>] rh_timer_func+0x0/0x20
>  [<88028dee>] run_timer_softirq+0xce/0x220
>  [<8821dde0>] rh_timer_func+0x0/0x20
>  [<88023d32>] __do_softirq+0x72/0x120
>  [<88023e46>] do_softirq+0x66/0xa0
>  [<883c41c0>] schedule+0x0/0x4c0
