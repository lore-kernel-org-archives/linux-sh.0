From: Valentine <valentine.barshak@cogentembedded.com>
Date: Mon, 07 Oct 2013 23:57:44 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <52534A78.2010400@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/08/2013 03:27 AM, Valentine Barshak wrote:
> This adds RCAR Gen2 USB phy support. The driver configures
> USB channels 0/2, which are shared between PCI USB hosts and
> USBHS/USBSS devices. It also controls internal USBHS phy.

[snip]

> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c b/drivers/usb/phy/phy-rcar-gen2-usb.c
> new file mode 100644
> index 0000000..b7b2102
> --- /dev/null
> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
> @@ -0,0 +1,271 @@

[snip]

> +
> +/* Low Power Status register */
> +#define USBHS_LPSTS_REG			0x02
> +#define USBHS_LPSTS_SUSPM		(1 << 14)
> +
> +/* USB General control register */
> +#define USBHS_UGCTRL_REG		0x80
> +#define USBHS_UGCTRL_CONNECT		(1 << 2)
> +#define USBHS_UGCTRL_PLLRESET		(1 << 0)
> +
> +/* USB General control register 2 */
> +#define USBHS_UGCTRL2_REG		0x84
> +#define USBHS_UGCTRL2_USB0_PCI		(1 << 4)
> +#define USBHS_UGCTRL2_USB0_HS		(3 << 4)
> +#define USBHS_UGCTRL2_USB2_PCI		(0 << 31)
> +#define USBHS_UGCTRL2_USB2_SS		(1 << 31)
> +
> +/* USB General status register */
> +#define USBHS_UGSTS_REG			0x88
> +#define USBHS_UGSTS_LOCK		(3 << 8)
> +

Please, note that the latest H2/M2 hardware manuals have the USB General 
status register (UGSTS) at offset 0x190.

(The PHY driver uses offsets relative to USBHS base + 0x100)

The PLL LOCK is supposed to be in bits 0-1 of the UGSTS register.
However, I've found that this is not correct, and the value read
from 0x190 offset is always 0.

The PLL LOCK status is actually read from bits 8-9 at the offset
of 0x188.

So when UTMI is suspended, the value read from 0x188 is 0x0.
When PLL is taken out of reset and normal UTMI mode is selected in
the LPSTS register, the register at 0x188 reads 0x300.

Thanks,
Val.
