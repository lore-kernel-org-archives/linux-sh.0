From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 03 Sep 2014 06:03:29 +0000
Subject: Re: [PATCH v2] usb: renesas_usbhs: fix driver dependencies
Message-Id: <5406AF31.4070906@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1601192.oClrOJlUe8@amdc1032> <CAMuHMdVp16nXS1GefyV0OD7Dwewct0UPTEEYLj+GKCrnBxjhLw@mail.gmail.com> <20140901233900.GB15867@verge.net.au>
In-Reply-To: <20140901233900.GB15867@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Magnus Damm <magnus.damm@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, USB list <linux-usb@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

(2014/09/02 8:39), Simon Horman wrote:
> On Mon, Sep 01, 2014 at 06:40:50PM +0200, Geert Uytterhoeven wrote:
>> On Mon, Sep 1, 2014 at 4:24 PM, Bartlomiej Zolnierkiewicz
>> <b.zolnierkie@samsung.com> wrote:
>>> Renesas USBHS controller support should be available only on
>>> Renesas ARM SoCs and SuperH architecture.
>>>
>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>>> Cc: Simon Horman <horms@verge.net.au>
>>> Cc: Magnus Damm <magnus.damm@gmail.com>
>>> ---
>>> v2:
>>> - s/ARCH_SH/SUPERH/ (thanks to Sergei Shtylyov)
>>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
