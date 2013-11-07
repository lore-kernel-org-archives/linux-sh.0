From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 07 Nov 2013 14:50:37 +0000
Subject: Re: [RFC V2 PATCH 2/2] usb: hcd: Initialize USB phy if needed
Message-Id: <527BA8BD.8080504@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383822869-20283-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383822869-20283-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/07/2013 05:06 PM, Peter Chen wrote:
>
>
>>
>> +#ifdef CONFIG_USB_PHY
>> +	if (!hcd->phy) {
>> +		struct usb_phy *phy = usb_get_phy_dev(hcd->self.controller,
>> 0);
>> +
>> +		if (IS_ERR(phy)) {
>> +			retval = PTR_ERR(phy);
>> +			if (retval = -EPROBE_DEFER)
>> +				return retval;
>> +		} else {
>> +			retval = usb_phy_init(phy);
>> +			if (retval) {
>> +				usb_put_phy(phy);
>> +				return retval;
>> +			}
>> +			hcd->phy = phy;
>> +			hcd->remove_phy = 1;
>> +		}
>> +	}
>> +#endif
>> +
>
> If the platform doesn't has phy driver, and with CONFIG_USB_PHY enabled, it
> will have problem for above code.
>

It shouldn't have any problems since there's no phy bound to the HCD in this case.
Thus, usb_get_phy_dev returns -ENODEV and the HCD will be added as usual.

> Peter

Thanks,
Val.

