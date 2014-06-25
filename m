From: Vivek Gautam <gautam.vivek@samsung.com>
Date: Wed, 25 Jun 2014 10:44:30 +0000
Subject: Re: [PATCH v3] usb: hcd: add generic PHY support
Message-Id: <CAFp+6iF8+w7zdovneJiczR5j0h11c9ieppeKRSx8L2V0nnPfmw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538891DC.605@renesas.com>
In-Reply-To: <538891DC.605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,


On Fri, May 30, 2014 at 7:42 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> From Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Add the generic PHY support, analogous to the USB PHY support. Intended it to be
> used with the PCI EHCI/OHCI drivers and the xHCI platform driver.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
> This patch is against the 'usb-next' branch of Greg KH's 'usb.git' repo.
> (commit id = 70d2f61fc7559df3d5be32a9d01efdb9ee1b11d8)
>
> Changes in version 3:
>  - rebased the current usb-next.
>  - I tested this patch on my R-Car H2 USB 3.0 driver (not merged yet)
>
>  drivers/usb/core/hcd.c  |   42 ++++++++++++++++++++++++++++++++++++++++--
>  include/linux/usb/hcd.h |    3 ++-
>  2 files changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index bec31e2..2841149 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -42,6 +42,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/types.h>
>
> +#include <linux/phy/phy.h>
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
>  #include <linux/usb/phy.h>
> @@ -2649,6 +2650,29 @@ int usb_add_hcd(struct usb_hcd *hcd,
>                 }
>         }
>
> +       if (IS_ENABLED(CONFIG_GENERIC_PHY)) {
> +               struct phy *phy = phy_get(hcd->self.controller, "usb");

The xHCI host controller is going to have two controllers (main and
shared) USB2 controller and
USB3 controller. So they will have two different PHYs.
For example, the DWC3, which has a xHCI controller, has to have 2
different phys -- usb2-phy and usb3-phy.

So, how the two 'hcd's' will be able to differentiate and get two separate PHYs.
Unfortunately, the xHCI with DWC3 doesn't have a device node too, so
it needs to have
a way out to look up the PHYs (in a way suggested by Heikki :
    usb: dwc3: host: convey the PHYs to xhci
    (https://lkml.org/lkml/2014/6/5/585) and related patch series.
But this also has an issue, since we need to have two separate
constant strings to distinguish between the two PHYs,
while creating the lookup table.

So how do you suggest me to get link the two PHYs in DWC3 with the
XHCI host controller, the issue which i am
facing currently while working with the patch:
usb: host: xhci-plat: Add support to get PHYs    and the related patch
series, since we need to handle PHY from the hcd.

> +
> +               if (IS_ERR(phy)) {
> +                       retval = PTR_ERR(phy);
> +                       if (retval = -EPROBE_DEFER)
> +                               goto err_phy;
> +               } else {
> +                       retval = phy_init(phy);
> +                       if (retval) {
> +                               phy_put(phy);
> +                               goto err_phy;
> +                       }
> +                       retval = phy_power_on(phy);
> +                       if (retval) {
> +                               phy_exit(phy);
> +                               phy_put(phy);
> +                               goto err_phy;
> +                       }
> +                       hcd->gen_phy = phy;
> +               }
> +       }
> +
>         dev_info(hcd->self.controller, "%s\n", hcd->product_desc);
>
>         /* Keep old behaviour if authorized_default is not in [0, 1]. */
> @@ -2664,7 +2688,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
>          */
>         if ((retval = hcd_buffer_create(hcd)) != 0) {
>                 dev_dbg(hcd->self.controller, "pool alloc failed\n");
> -               goto err_remove_phy;
> +               goto err_create_buf;
>         }
>
>         if ((retval = usb_register_bus(&hcd->self)) < 0)
> @@ -2791,7 +2815,14 @@ err_allocate_root_hub:
>         usb_deregister_bus(&hcd->self);
>  err_register_bus:
>         hcd_buffer_destroy(hcd);
> -err_remove_phy:
> +err_create_buf:
> +       if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->gen_phy) {
> +               phy_power_off(hcd->gen_phy);
> +               phy_exit(hcd->gen_phy);
> +               phy_put(hcd->gen_phy);
> +               hcd->gen_phy = NULL;
> +       }
> +err_phy:
>         if (hcd->remove_phy && hcd->phy) {
>                 usb_phy_shutdown(hcd->phy);
>                 usb_put_phy(hcd->phy);
> @@ -2868,6 +2899,13 @@ void usb_remove_hcd(struct usb_hcd *hcd)
>
>         usb_deregister_bus(&hcd->self);
>         hcd_buffer_destroy(hcd);
> +
> +       if (IS_ENABLED(CONFIG_GENERIC_PHY) && hcd->gen_phy) {
> +               phy_power_off(hcd->gen_phy);
> +               phy_exit(hcd->gen_phy);
> +               phy_put(hcd->gen_phy);
> +               hcd->gen_phy = NULL;
> +       }
>         if (hcd->remove_phy && hcd->phy) {
>                 usb_phy_shutdown(hcd->phy);
>                 usb_put_phy(hcd->phy);
> diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
> index 485cd5e..2aefbcc 100644
> --- a/include/linux/usb/hcd.h
> +++ b/include/linux/usb/hcd.h
> @@ -106,7 +106,8 @@ struct usb_hcd {
>          * OTG and some Host controllers need software interaction with phys;
>          * other external phys should be software-transparent
>          */
> -       struct usb_phy  *phy;
> +       struct usb_phy          *phy;
> +       struct phy              *gen_phy;
>
>         /* Flags that need to be manipulated atomically because they can
>          * change while the host controller is running.  Always use
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
