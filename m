From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 02 Oct 2014 11:16:10 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: rename phy to usb_phy in usbhs_priv
Message-Id: <542D33FA.1040605@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412236953-1084-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412236953-1084-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

(2014/10/02 18:52), Sergei Shtylyov wrote:
> Hello.
> 
> On 10/2/2014 12:02 PM, Yoshihiro Shimoda wrote:
> 
>> To support a generic phy driver in this driver later, this patch
>> renames "struct usb_phy *phy" to "struct usb_phy *usb_phy".
> 
>> This patch also cleans up this code.
> 
>    I think it's better to do rename and "cleanup" in separate patches.

Thank you for the point. I will separate them.

Best regards,
Yoshihiro shimoda

>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>   drivers/usb/renesas_usbhs/common.h |    2 +-
>>   drivers/usb/renesas_usbhs/rcar2.c  |   48 +++++++++++++++++++-----------------
>>   2 files changed, 27 insertions(+), 23 deletions(-)
> 
> [...]
> 
> WBR, Sergei
> 
