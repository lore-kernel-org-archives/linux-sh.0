From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 26 May 2014 13:55:49 +0000
Subject: Re: [PATCH usb: phy: add run-time dependencies to R-Car driver
Message-Id: <538347E5.5030706@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2252714.CbdvSBxGFE@avalon>
In-Reply-To: <2252714.CbdvSBxGFE@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/26/2014 04:50 PM, Laurent Pinchart wrote:

>> The Renesas R-Car USB PHY driver only supports the R8A7778 and
>> R8A7779, it isn't useful on other systems unless build testing.

>> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Could you please CC the linux-sh mailing list for similar patches in the
> future ?

> Sergei, any opinion on this ?

    I wouldn't object.

>> ---
>>   drivers/usb/phy/Kconfig |    1 +
>>   1 file changed, 1 insertion(+)

>> --- linux-3.15-rc6.orig/drivers/usb/phy/Kconfig	2014-04-14
>> 09:42:31.481112766 +0200 +++
>> linux-3.15-rc6/drivers/usb/phy/Kconfig	2014-05-23 10:11:59.979813625 +0200
>> @@ -208,6 +208,7 @@ config USB_MXS_PHY
>>   config USB_RCAR_PHY
>>   	tristate "Renesas R-Car USB PHY support"
>>   	depends on USB || USB_GADGET
>> +	depends on ARCH_R8A7778 || ARCH_R8A7779 || COMPILE_TEST
>>   	select USB_PHY
>>   	help
>>   	  Say Y here to add support for the Renesas R-Car USB common PHY driver.

WBR, Sergei

