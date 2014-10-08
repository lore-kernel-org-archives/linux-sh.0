From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 08 Oct 2014 05:43:53 +0000
Subject: Re: [PATCH v2 3/3] usb: renesas_usbhs: add support for generic PHY
Message-Id: <5434CC49.2020506@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412653386-5856-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412653386-5856-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Tuesday 07 October 2014 07:39 PM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Oct 07, 2014 at 12:43:06PM +0900, Yoshihiro Shimoda wrote:
>> This patch adds support for the generic PHY. The generic PHY will be
>> used in multiplatform environment.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Kishon, does this look ok to you ?

yes.. looks alright to me.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
>> ---
>>  drivers/usb/renesas_usbhs/common.h |    1 +
>>  drivers/usb/renesas_usbhs/rcar2.c  |   29 +++++++++++++++++++++++++++++
>>  2 files changed, 30 insertions(+)
>>
>> diff --git a/drivers/usb/renesas_usbhs/common.h b/drivers/usb/renesas_usbhs/common.h
>> index e0d53c5..c45667f 100644
>> --- a/drivers/usb/renesas_usbhs/common.h
>> +++ b/drivers/usb/renesas_usbhs/common.h
>> @@ -270,6 +270,7 @@ struct usbhs_priv {
>>  	struct usbhs_fifo_info fifo_info;
>>  
>>  	struct usb_phy *usb_phy;
>> +	struct phy *phy;
>>  };
>>  
>>  /*
>> diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
>> index 485b889..8fc15c0 100644
>> --- a/drivers/usb/renesas_usbhs/rcar2.c
>> +++ b/drivers/usb/renesas_usbhs/rcar2.c
>> @@ -12,6 +12,7 @@
>>  
>>  #include <linux/gpio.h>
>>  #include <linux/of_gpio.h>
>> +#include <linux/phy/phy.h>
>>  #include <linux/platform_data/gpio-rcar.h>
>>  #include <linux/usb/phy.h>
>>  #include "common.h"
>> @@ -21,6 +22,16 @@ static int usbhs_rcar2_hardware_init(struct platform_device *pdev)
>>  {
>>  	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
>>  
>> +	if (IS_ENABLED(CONFIG_GENERIC_PHY)) {
>> +		struct phy *phy = phy_get(&pdev->dev, "usb");
>> +
>> +		if (IS_ERR(phy))
>> +			return PTR_ERR(phy);
>> +
>> +		priv->phy = phy;
>> +		return 0;
>> +	}
>> +
>>  	if (IS_ENABLED(CONFIG_USB_PHY)) {
>>  		struct usb_phy *usb_phy = usb_get_phy_dev(&pdev->dev, 0);
>>  
>> @@ -38,6 +49,11 @@ static int usbhs_rcar2_hardware_exit(struct platform_device *pdev)
>>  {
>>  	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
>>  
>> +	if (priv->phy) {
>> +		phy_put(priv->phy);
>> +		priv->phy = NULL;
>> +	}
>> +
>>  	if (priv->usb_phy) {
>>  		usb_put_phy(priv->usb_phy);
>>  		priv->usb_phy = NULL;
>> @@ -52,6 +68,19 @@ static int usbhs_rcar2_power_ctrl(struct platform_device *pdev,
>>  	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
>>  	int retval = -ENODEV;
>>  
>> +	if (priv->phy) {
>> +		if (enable) {
>> +			retval = phy_init(priv->phy);
>> +
>> +			if (!retval)
>> +				retval = phy_power_on(priv->phy);
>> +		} else {
>> +			phy_power_off(priv->phy);
>> +			phy_exit(priv->phy);
>> +			retval = 0;
>> +		}
>> +	}
>> +
>>  	if (priv->usb_phy) {
>>  		if (enable) {
>>  			retval = usb_phy_init(priv->usb_phy);
>> -- 
>> 1.7.9.5
>>
> 
