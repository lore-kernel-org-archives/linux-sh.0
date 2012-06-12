From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 12 Jun 2012 00:23:00 +0000
Subject: Re: usb: ehci-sh: fix illegal phy_init() running when platform_data is NULL
Message-Id: <4FD68BE4.2060401@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FD5AF09.7060707@renesas.com>
In-Reply-To: <4FD5AF09.7060707@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

2012/06/11 22:53, Alan Stern wrote:
> On Mon, 11 Jun 2012, Shimoda, Yoshihiro wrote:
> 
>> If the platform_data is not set, pdata will be uninitialized value.
>> Then, the phy_init() may run on illegal address.
> 
> I don't see how this patch fixes that problem.

The driver has the following code:

	if (pdata && pdata->phy_init)
		pdata->phy_init();

So, if the condition is true when the pdata is uninitialize value,
the driver may jump the illegal pdata->phy_init().

I will modify this patch to add this patch description.

>> This patch also fixes the following warning:
>>
>>   CC      drivers/usb/host/ehci-hcd.o
>> drivers/usb/host/ehci-sh.c: In function ‘ehci_hcd_sh_probe’:
>> drivers/usb/host/ehci-sh.c:104: warning: ‘pdata’ may be used uninitialized in this function
> 
> That alone is a good enough reason to accept the patch.  You might want
> to update the patch description, though.
> 
< snip >
> 
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 

Thank you for the Acked-by:

Best regards,
Yoshihiro Shimoda
