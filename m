From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 22 May 2016 06:32:05 +0000
Subject: Re: SH7760
Message-Id: <87vb26sivu.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <CABatt_wtci8+eCcbVJ3FgJ=wv-JTHKN-9Xy+1rXGf-iix=5txQ@mail.gmail.com>
In-Reply-To: <CABatt_wtci8+eCcbVJ3FgJ=wv-JTHKN-9Xy+1rXGf-iix=5txQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 20 May 2016 23:49:04 +0900,
Martin Townsend wrote:
> 
> Hi,
> 
> Is the USB interface on the SH7760 compatible with the OHCI driver in
> the 4.1 linux kernel.
> 
> I've setup the platform as follows:
> 
> #define USB_IRQ evt2irq(0xa00)
> #define SH7760_USB_BASE 0xFE340000
> #define SH7760_USB_IOLEN 0x58
> 
> static struct usb_ohci_pdata usb_ohci_pdata;
> 
> static struct resource sh7760_usb_resources[] = {
> DEFINE_RES_MEM_NAMED(SH7760_USB_BASE, SH7760_USB_IOLEN,
>     "sh7760-usb-memory"),
> DEFINE_RES_IRQ_NAMED(USB_IRQ, "sh7760-usb-irq"),
> };
> 
> static struct platform_device sh7760_usb_host_device = {
> .name = "ohci-platform",
> .id = -1,
> .dev = {
> .dma_mask = NULL, /*  not use dma */
> .coherent_dma_mask = 0xffffffff,
> .platform_data = &usb_ohci_pdata,
> },
> .num_resources = ARRAY_SIZE(sh7760_usb_resources),
> .resource = sh7760_usb_resources,
> };
> 
> enabled the OHCI driver
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_SH=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> 
> Setup PCF
> /* Setup Port H Pull-Up Control Register:- Pull Ups on PH7 to PH3 */
> __raw_writeb(0xF8, PHPUPR);
> 
> /* Setup Port H Control Register so that USB Peripheral Module is set */
> __raw_writew(0x4000, PHCR);
> __raw_writeb(0x00, PHDR);
> 
> 
> but I get the following error:
> 
> [    3.600000] usb 1-1: new full-speed USB device number 2 using ohci-platform
> [    3.872000] ohci-platform ohci-platform: frame counter not updating; disabled
> [    3.872000] ohci-platform ohci-platform: HC died; cleaning up
> 
> 
> Any ideas as to what I'm missing?  I know the hardware is fine as I
> have a 2.6 kernel running that uses a SH7760 specific OHCI driver.

Are you enable clock of USB controller?.
Plase see CLKSTP00 setting.

> Many Thanks,
> Martin.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
