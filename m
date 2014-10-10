From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 10 Oct 2014 00:29:18 +0000
Subject: Re: [PATCH] usb: host: xhci-plat: fix suspend/resume on xhci-rcar
Message-Id: <5437285E.5080302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

(2014/10/09 23:14), Felipe Balbi wrote:
> On Thu, Oct 09, 2014 at 01:45:47PM +0900, Yoshihiro Shimoda wrote:
>> This patch fixes an issue that suspend/resume cannot work correctly
>> on xhci-rcar because the xhci driver output the following log:
>>
>>         xhci-hcd ee000000.usb: WARN: xHC CMD_RUN timeout
>>
>> So, this patch adds to set the XHCI_SLOW_SUSPEND quirk if xhci-rcar.
> 
> do you have erratum number confirming this is needed for your platform ?

At the moment, I don't have such number... I just tested it on my platform.
And, the handshake in xhci_suspend needs about 80 ms...
Anyway, I will ask platform team about this behavior.

> We really don't want to enable quirks just because they help, we need to
> be sure HW is quirky. For example, we triggered the same thing on DRA7xx
> (which uses dwc3) but after digging a little, it seems like we're having
> memory access latency issues, not a problem with XHCI.

Thank for the information.
I got it. So, I will dig about this issue on my platform.

>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  This patch is based on the Greg's usb.git / usb-next branch.
>>  (commit id : 4ed9a3d455558406cad83d38764ee659de25851c)
>>
>>  drivers/usb/host/xhci-plat.c |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
>> index 3d78b0c..a266883 100644
>> --- a/drivers/usb/host/xhci-plat.c
>> +++ b/drivers/usb/host/xhci-plat.c
>> @@ -27,12 +27,18 @@ static struct hc_driver __read_mostly xhci_plat_hc_driver;
>>  
>>  static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
>>  {
>> +	struct device_node *of_node = dev->of_node;
> 
> add also a blank line here.

Thank you for the point. I will fix it.

>>  	/*
>>  	 * As of now platform drivers don't provide MSI support so we ensure
>>  	 * here that the generic code does not try to make a pci_dev from our
>>  	 * dev struct in order to setup MSI
>>  	 */
>>  	xhci->quirks |= XHCI_PLAT;
>> +
>> +	/* QUIRK: R-Car xHCI must be suspended extra slowly */
> 
> why ? Who says that ? Where's the errata document ?

As I said above, Just a result on my environment.
So, I will ask platform team.

Best regards,
Yoshihiro Shimoda

>> +	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
>> +	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
>> +		xhci->quirks |= XHCI_SLOW_SUSPEND;
>>  }
>>  
>>  /* called during probe() after chip reset completes */
>> -- 
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
