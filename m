From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 05 Mar 2018 12:06:44 +0000
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and cleanups
Message-Id: <CAPDyKFr0=oR2s-SiejG580iy71dUh-K64Ya=trEjZE4zmc5Xfg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <20180304224248.mzhsvl4ccmtzg5am@ninjato> <CAPDyKFq_1mR=b3iu6o4ZJQeAjRnWf_tzb=__7SxvZYqDNCo2bg@mail.gmail.com>
 <20180305092259.bcpfbzvvoqxsfomf@katana> <CAK7LNATrq11iaa=uTuJx8Z9XMDg9CA8Nf0jdU3GkLKFH5fH9Gg@mail.gmail.com>
In-Reply-To: <CAK7LNATrq11iaa=uTuJx8Z9XMDg9CA8Nf0jdU3GkLKFH5fH9Gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Magnusson <ulfalizer@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rob Herring <robh@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>

On 5 March 2018 at 10:34, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Hi Ulf, Wolfram,
>
> 2018-03-05 18:22 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>>
>>> I have added Wolframs tags to the already applied patches and applied
>>> that last two, 15 and 16.
>>
>> Thanks. Please note that patch 14 misses my Rev tag. (I gave it
>> yesterday but the patch was accidently applied before. One round too
>> early, so to say).

Added rev. tag.

>>
>>> They are all present in my next branch. The fix that Wolfram sent on
>>> top, is added immediately after the commit it fixes.
>>
>> Could we also squash it, then?
>>
>
> If Wolfram is fine with squashing,
> that would be cleaner.
>

Done.

> In that case, can you add Tested-by
> to patch 12?

Done.

Kind regards
Uffe
