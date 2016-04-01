From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 01 Apr 2016 19:55:49 +0000
Subject: Re: [PATCH v3 09/11] i2c: rcar: revoke START request early
Message-Id: <56FED245.4010503@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
 <1447948611-2615-10-git-send-email-wsa@the-dreams.de>
 <56FD9080.4090203@cogentembedded.com> <20160331224838.GA7381@katana>
In-Reply-To: <20160331224838.GA7381@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>

Hello.

On 04/01/2016 01:48 AM, Wolfram Sang wrote:

>>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>>
>>> If we don't clear START generation as soon as possible, it may cause
>>> another message to be generated, e.g. when receiving NACK in address
>>> phase. To keep the race window as small as possible, we clear it right
>>> at the beginning of the interrupt. We don't need any checks since we
>>> always want to stop START and STOP generation on the next occasion after
>>> we started it.
>>>
>>> This patch improves the situation but sadly does not completely fix it.
>>> It is still to be researched if we can do better given this HW design.
>>>
>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>>     Thanks for a great work, Wolfram!
>>     We need this patch in -stable kernels. The R-Car audio just doesn't work
>> without it...

> Really only this patch?

    Well, my "reverse" bisection pointed at it. :-)

> IIRC my tests showed that if you don't remove
> the spinlocks (patch 4), the interrupt latency will already be too high
> again.

    Thank you for the valuable info!

> In any case, you'd need to do some careful backporting to rip
> this out of the whole refactoring series.

    Yes, I've already figured that.

> But maybe you did that already
> and have good experiences?

    Not yet, I will report back after more backporting/testing.

MBR, Sergei

