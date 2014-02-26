From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Feb 2014 10:14:14 +0000
Subject: Re: [PATCH 02/03] pinctrl: sh-pfc: r8a7791: SD1_CLK fix
Message-Id: <CANqRtoT=xOvZ0bwxXUghjrn3=k5544ic7ef880VetXtQYs3cqg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140212042610.10516.36546.sendpatchset@w520>
In-Reply-To: <20140212042610.10516.36546.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Mon, Feb 24, 2014 at 11:48 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Mon, Feb 17, 2014 at 10:45 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>
>> Hi Magnus,
>>
>> (CC'ing Linus Walleij)
>>
>> Thank you for the patch.
>>
>> On Wednesday 12 February 2014 13:26:10 Magnus Damm wrote:
>>> From: Magnus Damm <damm@opensource.se>
>>>
>>> Fix the SD1_CLK handling for r8a7791. Without this patch
>>> it is impossible to request all pins needed for SDHI1 on
>>> the Koelsch board.
>>>
>>> Signed-off-by: Magnus Damm <damm@opensource.se>
>>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Since it seems I don't have this patch, if it is a fix on the critical path
> please send it to me so I can apply it for fixes.
>
> (Or if non-critical, atleast let me apply it to devel...)

Thanks for the reminder! I don't consider this patch to be
particularly critical, but if you could include it in devel than that
would be greatly appreciated. I just resent the patch as "[PATCH]
pinctrl: sh-pfc: r8a7791: SD1_CLK fix" based on linux-next tag
next-20140225. This time I remembered to include you, sorry for last
time!

If you want me to rework the patch somehow to cope with all the recent
PFC changes then please let me know and I will step up.

Cheers,

/ magnus
