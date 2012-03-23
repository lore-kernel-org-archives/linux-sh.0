From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 23 Mar 2012 04:38:38 +0000
Subject: Re: [PATCH v2] usb: ehci-sh: Add PHY init function with platform data
Message-Id: <4F6BFE4E.9040506@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1332312420-31674-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Paul Mundt さんは書きました:
> On Wed, Mar 21, 2012 at 03:47:00PM +0900, Nobuhiro Iwamatsu wrote:
>> In devices using ehci-sh, initialization of the PHY may be necessary.
>> This adds platform data to ehci-sh and provide function to initialize PHY.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> CC: Shimoda Yoshihiro <yoshihiro.shimoda.uh@renesas.com>
> 
> It's impossible to say whether this makes sense or not without first
> seeing what you are trying to do in the callback.
> 

For example, it is necessary to initialize it after having
ebabled clock of ehci in sh7734.
I perform initialization CPU specific in callback.
For example, following.

/* USB */
#define USBPCTRL1		0xFFE70804
#define USBST			0xFFE70808
#define USBEH0			0xFFE7080C
#define USBOH0			0xFFE7081C
#define USBCTL0			0xFFE70858

#define USBPCTRL1_RST       (1 << 31)
#define USBPCTRL1_PHYENB    (1 << 0)
#define USBPCTRL1_PLLENB    (1 << 1)
#define USBPCTRL1_PHYRST    (1 << 2)
#define USBST_ACT           (1 << 31)
define USBST_PPL           (1 << 30)
#define USBCTL0_CLKSEL      (1 << 7)

static void usb_ehci_phy_init(void)
{
	/* Init check */
	if (__raw_readl(USBPCTRL1) & USBPCTRL1_PHYRST)
		return;

	__raw_writel(USBPCTRL1_RST, USBPCTRL1);
	__raw_writel(0, USBPCTRL1);

	__raw_writel(USBPCTRL1_PHYENB, USBPCTRL1);
	__raw_writel(__raw_readl(USBPCTRL1)|USBPCTRL1_PLLENB, USBPCTRL1);
	while (__raw_readl(USBST) != (USBST_ACT|USBST_PPL))
		cpu_relax();

	__raw_writel(__raw_readl(USBPCTRL1) | USBPCTRL1_PHYRST, USBPCTRL1);
}

Should I move this by initialization of board?
