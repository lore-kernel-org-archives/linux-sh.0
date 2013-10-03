From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 03 Oct 2013 09:42:26 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <524D3C02.30201@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/03/2013 01:01 PM, Magnus Damm wrote:
> Hi Valentine,
>
> On Thu, Oct 3, 2013 at 7:52 AM, Valentine
> <valentine.barshak@cogentembedded.com> wrote:
>> On 10/02/2013 04:18 AM, Magnus Damm wrote:
>>> Have you considered putting these SoC specific bits into drivers/usb/...
>>
>> I'll try to add device id table and move it to renesas_usbhs driver.
>
> Sounds good, thank you!

Looks like Morimoto-san doesn't agree with that.

>
>> Hope the "renesas_usbhs_rcar_h2" device name is not too long.
>
> Please use SoC model string "r8a7790" for DT like other drivers, as an
> example see the following commit:

OK, but I wasn't going to make renesas_usbhs a DT driver at least for now.
IIUC, it's going to involve a rework of USBHS bindings for other boards.
which have different platform code for PHY setup.
I thought this had to be a separate work.

Do you want me to make it DT-compatible only for r8a7790?

I planned to add a platform device id table for now. Something like
"usbhs-rcar_h2" for r8a7790 and "renesas_usbhs" for other SoCs.

>
> commit df1d0584b2292df5b9d576d7e5246e94616220a1
> Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Date:   Thu Aug 29 17:14:49 2013 +0200
>
>      ARM: shmobile: update SDHI DT compatibility string to the
> <unit>-<soc> format
>
> Cheers,
>
> / magnus
>

Thanks,
Val.
