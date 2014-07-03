From: Vivek Gautam <gautam.vivek@samsung.com>
Date: Thu, 03 Jul 2014 06:12:49 +0000
Subject: Re: [PATCH v3] usb: hcd: add generic PHY support
Message-Id: <CAFp+6iE7x6=XbbjdMTLVY_x6xU78pignEm1dTsaX_CmC-31f5w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538891DC.605@renesas.com>
In-Reply-To: <538891DC.605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Cc: Alan, Mathias Nyman, Julius Werner, Heikki Krogerus

Hi,


On Wed, Jun 25, 2014 at 4:02 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Hi Sergei,
>
>
> On Fri, May 30, 2014 at 7:42 PM, Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> From Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> Add the generic PHY support, analogous to the USB PHY support. Intended it to be
>> used with the PCI EHCI/OHCI drivers and the xHCI platform driver.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>> This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.
>> (commit id = 70d2f61fc7559df3d5be32a9d01efdb9ee1b11d8)
>>
>> Changes in version 3:
>>  - rebased the current usb-next.
>>  - I tested this patch on my R-Car H2 USB 3.0 driver (not merged yet)
>>
>>  drivers/usb/core/hcd.c  |   42 ++++++++++++++++++++++++++++++++++++++++--
>>  include/linux/usb/hcd.h |    3 ++-
>>  2 files changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index bec31e2..2841149 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -42,6 +42,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/types.h>
>>
>> +#include <linux/phy/phy.h>
>>  #include <linux/usb.h>
>>  #include <linux/usb/hcd.h>
>>  #include <linux/usb/phy.h>
>> @@ -2649,6 +2650,29 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>                 }
>>         }
>>
>> +       if (IS_ENABLED(CONFIG_GENERIC_PHY)) {
>> +               struct phy *phy = phy_get(hcd->self.controller, "usb");
>
> The xHCI host controller is going to have two controllers (main and
> shared) USB2 controller and
> USB3 controller. So they will have two different PHYs.
> For example, the DWC3, which has a xHCI controller, has to have 2
> different phys -- usb2-phy and usb3-phy.
>
> So, how the two 'hcd's' will be able to differentiate and get two separate PHYs.
> Unfortunately, the xHCI with DWC3 doesn't have a device node too, so
> it needs to have
> a way out to look up the PHYs (in a way suggested by Heikki :
>     usb: dwc3: host: convey the PHYs to xhci
>     (https://lkml.org/lkml/2014/6/5/585) and related patch series.
> But this also has an issue, since we need to have two separate
> constant strings to distinguish between the two PHYs,
> while creating the lookup table.
>
> So how do you suggest me to get link the two PHYs in DWC3 with the
> XHCI host controller, the issue which i am
> facing currently while working with the patch:
> usb: host: xhci-plat: Add support to get PHYs    and the related patch
> series, since we need to handle PHY from the hcd.

Can someone please clear my doubt here.

This can help me getting a clear picture of how to align with the xhci's request
for PHY to let it handle any sort of phy-calibration, which we are
trying in the patch-series:
[PATCH v1 0/4] Fine tune USB 3.0 PHY on exynos5420
https://lkml.org/lkml/2014/6/6/202

I have also posted my doubts in the thread :
[PATCH 2/4] usb: host: xhci-plat: Add support to get PHYs
https://lkml.org/lkml/2014/6/25/150

[snip]


-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
