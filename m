From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 09 Jul 2014 10:11:44 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add R-Car Gen. 2 init and power control
Message-Id: <CAO3366ySCau6A7hXTDzHy4COH8he5YrB2A_kNxuua8qejeH8VQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1404831571-19817-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <87y4w3v1fa.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87y4w3v1fa.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jul 9, 2014 at 2:08 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Ulrich
>
> Thank you for your patch

Thank you for your review.

>> @@ -186,6 +192,8 @@ struct renesas_usbhs_platform_info {
>>        * driver use these param for some register
>>        */
>>       struct renesas_usbhs_driver_param       driver_param;
>> +
>> +     struct usb_phy *phy;
>>  };
>
> Using renesas_usbhs_platform_info for *phy is not good idea from my point of view.
> Because its memory is located on platform side.
> (this is the reason why usbhs_probe() using memcpy() for getting info->xxx)
>
> I guess struct usbhs_priv is good place,
> and you can use usbhs_pdev_to_priv() for this purpose ?

Yes, that seems more natural anyway.

CU
Uli
