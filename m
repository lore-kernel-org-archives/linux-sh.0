From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 02 Oct 2013 12:13:43 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <524C0DF7.8030409@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/02/2013 04:18 AM, Magnus Damm wrote:
> Hi Valentine,

Hi Magnus,

>
> Thanks for your patches.
>
> On Wed, Oct 2, 2013 at 3:30 AM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
>> This adds USBHS phy control callbacks to the Lager board and
>> registers USBHS device if the driver is enabled.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   arch/arm/mach-shmobile/board-lager.c | 142 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 142 insertions(+)
>>
>> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
>> index a8d3ce6..e408fc7 100644
>> --- a/arch/arm/mach-shmobile/board-lager.c
>> +++ b/arch/arm/mach-shmobile/board-lager.c
>
> Starting from here...
>
>> +/* USBHS registers */
>> +#define USBHS_LPSTS_REG                        0x102
>> +#define USBHS_LPSTS_SUSPM              (1 << 14)
>> +
>> +#define USBHS_UGCTRL_REG               0x180
>> +#define USBHS_UGCTRL_CONNECT           (1 << 2)
>> +#define USBHS_UGCTRL_PLLRESET          (1 << 0)
>> +
>> +#define USBHS_UGCTRL2_REG              0x184
>> +#define USBHS_UGCTRL2_USB0_PCI         (1 << 4)
>> +#define USBHS_UGCTRL2_USB0_HS          (3 << 4)
>> +#define USBHS_UGCTRL2_USB2_PCI         (0 << 31)
>> +#define USBHS_UGCTRL2_USB2_SS          (1 << 31)
>> +
>> +#define USBHS_UGSTS_REG                        0x190
>> +#define USBHS_UGSTS_LOCK               (3 << 0)
>> +
>> +struct usbhs_private {
>> +       struct renesas_usbhs_platform_info info;
>> +       struct platform_device *pdev;
>> +       struct clk *clk;
>> +};
>> +
>> +#define usbhs_get_priv(pdev) \
>> +       container_of(renesas_usbhs_get_info(pdev), struct usbhs_private, info)
>> +
>> +static int usbhs_power_on(void __iomem *base)
>> +{
>> +       u32 val;
>> +
>> +       val = ioread32(base + USBHS_UGCTRL_REG) & ~USBHS_UGCTRL_PLLRESET;
>> +       iowrite32(val, base + USBHS_UGCTRL_REG);
>> +
>> +       val = ioread16(base + USBHS_LPSTS_REG) | USBHS_LPSTS_SUSPM;
>> +       iowrite16(val, base + USBHS_LPSTS_REG);
>> +
>> +       /*
>> +        * The manual suggests to check PLL lock status in the UGSTS
>> +        * register before enabling connect, however, it is always 0.
>> +        */
>> +       val = ioread32(base + USBHS_UGCTRL_REG) | USBHS_UGCTRL_CONNECT;
>> +       iowrite32(val, base + USBHS_UGCTRL_REG);
>> +       return 0;
>> +}
>> +
>> +static int usbhs_power_off(void __iomem *base)
>> +{
>> +       u32 val;
>> +
>> +       val = ioread32(base + USBHS_UGCTRL_REG) & ~USBHS_UGCTRL_CONNECT;
>> +       iowrite32(val, base + USBHS_UGCTRL_REG);
>> +
>> +       val = ioread16(base + USBHS_LPSTS_REG) & ~USBHS_LPSTS_SUSPM;
>> +       iowrite16(val, base + USBHS_LPSTS_REG);
>> +
>> +       val = ioread32(base + USBHS_UGCTRL_REG) | USBHS_UGCTRL_PLLRESET;
>> +       iowrite32(val, base + USBHS_UGCTRL_REG);
>> +       return 0;
>> +}
>> +
>> +static int usbhs_power_ctrl(struct platform_device *pdev,
>> +                               void __iomem *base, int enable)
>> +{
>> +       if (enable)
>> +               return usbhs_power_on(base);
>> +
>> +       return usbhs_power_off(base);
>> +}
>
> ... to here it looks like this is USBHS support code for the r8a7790
> SoC, not the lager board.
>
> Have you considered putting these SoC specific bits into drivers/usb/...

I have. But I've decided to put all the USBHS-specific stuff into
board-specific code because I'm not sure why the PLL lock is always 0 on 
Lager (whether it's a SoC or board specific issue) and I don't have 
other boards with the same SoC to test. Even though the PLL lock status 
doesn't seem to behave as described in the docs, I haven't noticed any
issues with the USBHS.

I can move it to SoC files, but I'm once again not sure whether it 
should go into setup-r8a7790 or setup-rcar-gen2 because both SoCs seem 
to have identical USB subsystem.

>
> Thanks,
>
> / magnus
>

Thanks,
Val.
