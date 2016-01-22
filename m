From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Fri, 22 Jan 2016 11:36:59 +0000
Subject: Re: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <56A2145B.4090601@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On 22.01.2016 09:54, Wolfram Sang wrote:
> Hi Dirk,
>
>> First, regarding the clocks, if anybody from the experts could advise me how
>> we'd like to interface dynamic clocks to the existing Gen3 clock code, that
>> would be really welcome:
>
> I am not the clock expert, but I try to have a look next week.


I'll try to post a proposal for the SD clock, soon.


>> Second, I'm mainly interested in eMMC support for the Salvator-X. Therefore
>
> OK, nice to know. I have eMMC running now, without DMA and HS200, of
> course. My patches need some refactoring, though.
>
>> I picked (hopefully) all patches from the Renesas BSP to
>> renesas-drivers-2016-01-13-v4.4
>
> Yes, that's where I picked your clock patches from :)
>
>> so I'd suspect some memory overwriting. But what confuses me is that the
>> same code works fine on the the 4.2 based Renesas BSP. I have no idea
>> regarding this, yet.
>
> I usually don't have high hopes that putting more than a trivial amount
> of any BSP code on top of upstream will result in success ;)


I was at least hoping that the differences between the 4.2 BSP and the 
recent 4.4 development head are not that large that it would be possible 
"to make it work" picking that patches.

You are right, upstreaming them is an other topic, then ;)

Best regards

Dirk


