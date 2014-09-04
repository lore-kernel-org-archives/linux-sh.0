From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Sep 2014 21:51:07 +0000
Subject: Re: [PATCH] tmio_mmc_pio: prevent endless loop in tmio_mmc_set_clock()
Message-Id: <5408DECB.6000102@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405040219.30018.sergei.shtylyov@cogentembedded.com>	<53AC7B06.9070501@cogentembedded.com>	<54076BAA.4030105@cogentembedded.com> <CAPDyKFoWxCiVdeqJfx1s1bOPAr-_QmfxrXBHpZfmaupD4ED_bQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoWxCiVdeqJfx1s1bOPAr-_QmfxrXBHpZfmaupD4ED_bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>, Chris Ball <chris@printf.net>

Hello.

On 09/04/2014 03:00 PM, Ulf Hansson wrote:

>>>> I've spent a couple of days with the driver just hanging due to me
>>>> forgetting
>>>> to specify the external crystal frequency, so that clk_get_rate()
>>>> returned 0
>>>> and thus the loop in tmio_mmc_set_clock() never ended. I don't think
>>>> that's an
>>>> acceptable behavior, so I suggest that the minimum frequency is checked
>>>> for 0
>>>> in tmio_mmc_host_probe().

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>>> ---
>>>> The patch is against Chris Ball's 'mmc.git' repo's 'master' branch.

>>>      I'm still not seeing this patch applied anywhere in this repo...
>>> what's
>>> the problem with it?

>>     Chris, Ulf, Ian, what's the issue with this patch? Do you want me to
>> rework it?

> I guess it has been forgotten, sorry about that.

> Please rebase it towards my mmc tree, which is the one we are using
> currently and repost it.

    It should still apply flawlessly to your tree, want me to repost it anyway?

> Kind regards
> Uffe

WBR, Sergei

