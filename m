From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 07 Dec 2015 17:44:32 +0000
Subject: Re: [PATCH net] ravb: Remove clear unhandled interrupt
Message-Id: <5665C580.2090202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449402140-24272-1-git-send-email-ykaneko0929@gmail.com>
 <566489E8.8040605@cogentembedded.com>
 <CAH1o70LeSfwpcFicV=CCip=W1QOeYE3VioEv7L-XZCyMBgnTrA@mail.gmail.com>
In-Reply-To: <CAH1o70LeSfwpcFicV=CCip=W1QOeYE3VioEv7L-XZCyMBgnTrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello.

On 12/07/2015 07:59 PM, Yoshihiro Kaneko wrote:

>>> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>>>
>>> AVB-DMAC Reception Warning interrupt is not enabled, so it is not
>>> necessary to clear the interrupt.
>>>
>>> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>>
>>
>>     In principle I agree but perhaps we should clear RIC1 in probe() to not
>> depend on a state left from a bootloader?
>
> I think that it is a good idea.
> I'll add it to v2.

    Perhaps the ndo_open() method would be a better place...

>> MBR, Sergei

> Thanks,
> Kaneko

MBR, Sergei

