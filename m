From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Tue, 30 Jul 2013 14:15:37 +0000
Subject: Re: [PATCH] clocksource: em_sti: Convert to devm_* managed helpers
Message-Id: <51F7CA89.5070305@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1374848897-18545-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20130730020640.GA27724@verge.net.au> <51F7229D.7090706@linaro.org>
 <2725526.9tXHptSQgN@avalon>
In-Reply-To: <2725526.9tXHptSQgN@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On 07/30/2013 12:03 PM, Laurent Pinchart wrote:
> Hi Simon, John,
>=20
> On Monday 29 July 2013 19:19:09 John Stultz wrote:
>> On 07/29/2013 07:06 PM, Simon Horman wrote:
>>> [ CC John Stultz, Thomas Gleixner ]
>>>
>>> On Fri, Jul 26, 2013 at 04:28:17PM +0200, Laurent Pinchart wrote:
>>>> Replace kzalloc, clk_get, ioremap and request_irq by their managed
>>>> counterparts to simplify error paths.
>>>>
>>>> Signed-off-by: Laurent Pinchart
>>>> <laurent.pinchart+renesas@ideasonboard.com>
>>>
>>> Hi Laurent,
>>>
>>> I was recently asked for shmobile clocksource patches to be reviewed
>>> by the clocksource maintainers. I believe that means John Stultz
>>> and Thomas Gleixner who I have CCed on this email accordingly.
>>
>> Daniel Lezcano (cc'ed) is picking up maintainership of
>> clocksource/clockevent code in drivers/clocksource, so please cc him in
>> the future.
>=20
> Sure, will do so (I suppose Daniel will show up in MAINTAINERS, otherwise=
 I=20
> might forget).

Yes it is the case [1].

Please could you resend the patch, I don't see it in my mailbox.

Thanks
  -- Daniel

[1]
https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=3Dtimers=
/core&id=9222d247bcbaacc40fe15549158f9d67523c1ace





--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

