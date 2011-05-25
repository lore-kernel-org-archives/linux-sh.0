From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 May 2011 02:48:36 +0000
Subject: [PATCH 0/2] ARM: mach-shmobile: mackerel: renesas_usbhs support
Message-Id: <w3pd3j7v6kg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus

These are renesas_usbhs driver support for mackerel

Kuninori Morimoto(2)
         ARM: arch-shmobile: sh7372: add renesas_usbhs irq support
         ARM: mach-shmobile: mackerel: add renesas_usbhs support for USB1

I think #2 is challenge-full patch.
This patch try to add renesas_usbhs driver for USB1 which can be Host/Func.

USB1 can use USB-phy interrupt for connect/disconnect on mackerel.
This mean we can power off it by renesas_usbhs when USB-Func.

But for now, renesas_usbhs support Func only.
And many people want to use Host by r8a66597 (it is already supported).

This patch adds renesas_usbhs to USB1, but doesn't allow
both CONFIG_USB_RENESAS_USBHS and CONFIG_USB_R8A66597_HCD in same time.
Because same IRQ will be requested in different driver.

Please check it carefully.

Best regards
--
Kuninori Morimoto
 
