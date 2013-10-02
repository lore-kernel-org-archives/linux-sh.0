From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 02 Oct 2013 12:06:33 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <524C0C49.8090300@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/02/2013 04:09 AM, Kuninori Morimoto wrote:
>
> Hi Valentine

Hi Morimoto-san,

> (snip)
>
>> +static int usbhs_hardware_init(struct platform_device *pdev)
>> +{
>> +	struct usbhs_private *priv = usbhs_get_priv(pdev);
>> +	struct clk *clk;
>> +
>> +	clk = clk_get(NULL, "hsusb");
>> +	if (IS_ERR(clk))
>> +		return -ENODEV;
>
> It is automatically enable/disabled by driver
> if MSTP704 clock name was "renesas_usbhs".

The reason I did not bind usbhs clock to renesas_usbhs device is because
the same clock is also used by the lager_add_usb_devices() function in 
the next patches. We need that since the global USB settings that affect 
USBHS/USBSS and PCI USB host channel sharing are done in the USBHS 
UGCTRL2 register. So we need this clock even if the renesas_usbhs driver 
is disabled. IIUC, biding it to "renesas_usbhs" device would make it 
impossible to use the clock if renesas_usbhs device is not registered.

Thanks,
Val.

>
> Best regards
> ---
> Kuninori Morimoto
>

