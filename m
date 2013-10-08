From: Valentine <valentine.barshak@cogentembedded.com>
Date: Tue, 08 Oct 2013 08:03:57 +0000
Subject: Re: [PATCH 3/3] arm: shmobile: lager: Add USBHS support
Message-Id: <5253BC6D.5090301@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-4-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-4-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/08/2013 07:31 AM, Kuninori Morimoto wrote:
>
> Hi Valentine
>
>> This adds USBHS PHY and registers USBHS device if the driver is enabled.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
> (snip)
>> +/* USBHS */
>> +#if IS_ENABLED(CONFIG_USB_RENESAS_USBHS_UDC)
>> +static const struct resource usbhs_resources[] __initconst = {
>> +	DEFINE_RES_MEM(0xe6590000, 0x100),
>> +	DEFINE_RES_IRQ(gic_spi(107)),
>> +};
>
> Why it needs #if IS_ENABLED() ?
> I guess nothing happen if renesas_usbhs driver
> registered without CONFIG_USB_RENESAS_USBHS_UDC.
> But am I misunderstanding ?
>

Since USB channel 0 is shared between PCI USB host and USBHS
we'll still need it later to properly configure the channel.
Besides, is saves us some bits leaving all the unused callbacks and 
device structures out if we do not register the device when the driver 
is disabled.

Thanks,
Val.
