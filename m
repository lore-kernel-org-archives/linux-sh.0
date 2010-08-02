From: Arnd Hannemann <arnd@arndnet.de>
Date: Mon, 02 Aug 2010 18:17:16 +0000
Subject: Re: [bisected] sh_cmt Division by zero in kernel.
Message-Id: <4C570BAC.6090104@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <4C46A102.6000805@arndnet.de>
In-Reply-To: <4C46A102.6000805@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Am 02.08.2010 12:35, schrieb Magnus Damm:
>
> On Fri, Jul 23, 2010 at 4:35 PM, Arnd Hannemann <arnd@arndnet.de>
> wrote:
>> Am 22.07.2010 15:55, schrieb Magnus Damm:
>>> On Wed, Jul 21, 2010 at 4:25 PM, Arnd Hannemann <arnd@arndnet.de>
>>> wrote:
>>>> Git bisect identified following commit as bad:
>>>>
>>>> commit f4d7c3565c1692c54d9152b52090fe73f0029e37 Author: Paul
>>>> Mundt <lethal@linux-sh.org> Date:   Wed Jun 2 17:10:44 2010
>>>> +0900
>>>>
>>>> clocksource: sh_cmt: compute mult and shift before
>>>> registration Based on the sh_tmu change in
>>>> 66f49121ffa41a19c59965b31b046d8368fec3c7 ("clocksource: sh_tmu:
>>>> compute mult and shift before registration"). The same issues
>>>> impact the sh_cmt driver, so we take the same approach here.
>>>> Cc: stable@kernel.org Signed-off-by: Paul Mundt
>>>> <lethal@linux-sh.org>
>>>>
>>> If you revert that one (and perhaps
>>> 5967d33ce8a030f01a716fc0b25fcb03744a5fda as well), does it fix
>>> your crash?
>>>
>>
>> Yes, if I revert both 5967d33ce8a030f01a716fc0b25fcb03744a5fda and
>> f4d7c3565c1692c54d9152b52090fe73f0029e37, this fixes the crash and
>> time is running "normal".
>>
>> I reverted both mainly because the revert of
>> f4d7c3565c1692c54d9152b52090fe73f0029e37 would not go through
>> cleanly on top of the current tree.
>
> I think this patch should solve the issue:
> http://www.spinics.net/lists/linux-sh/msg05433.html
>
> If you have time, please give it a try.

I tried and this actually fixes the bug.

Thanks a lot,
Arnd


