From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 14:13:46 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <CANqRtoRLKnTRW052KfwkZo43TBeQyGGvOk1qRw0UGSvTCNxKZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Wed, Jul 24, 2013 at 9:58 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 24-07-2013 8:45, Magnus Damm wrote:
>
>>>>>> sh_eth driver which needs platform data at the time of
>>>>>> registration is used from BockW only.
>>>>>> Now, ARM/shmobile aims to support DT,
>>>>>> and the C code base board support will be removed in the future.
>>>>>> The driver registration method which needs platform data
>>>>>> and which is not shared complicates codes.
>>>>>> This patch registers it on board code as cleanup C code
>
>
>>>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
>
>>>>>      NAK.
>
>
>>>> Please provide some reasoning for your objection to this change.
>>>> Likewise for other patches in this series to which you have replied
>>>> in the same manner. I for one do not understand what it is you object
>>>> to.
>
>
>>>     Sorry, I was just out of words when I saw this. I for one do not
>>> understand how this change will help the DT support and to me it seems no
>>> more than a pointless churn and step backward from what we had. Under no
>>> circumstances I will accept this change -- I'm totally opposed to the
>>> idea
>>> of moving the SoC devices to the board code.
>
>
>> Thanks for emailing once more and explaining your reasons behind the
>> NAK. Please allow me to step in here and explain things a bit.
>
>
>> Originally on SH and ARM mach-shmobile we have divided platform
>> devices into two categories - SoC specific and board specific. As
>> expected, SoC specific devices go in setup-xxx.c and board specific
>> devices go into board-xxx.c. So far so good.
>
>
>> It may become a bit more unclear in some cases when part of the
>> platform device data is board specific but other parts are SoC
>> specific. Historically we have simply made those board specific. For
>> various reasons I'd like to keep the code that way.
>
>
>    I beg to differ.

What? You mean that that's not the way we did things the last 5 years?

> USB PHY doesn't have SoC specific platform data, yet
> Morimoto-san is again moving it to the board code. Why?

I don't know, why don't you ask him? Frankly I don't care very much either.

>    Also, concerning sh_eth device: hopefully, it's going to lose its SoC
> specific platform data soon due to my efforts. What then, move the device to
> the SoC code again?

I trust Morimoto-san to do whatever he needs to do to make the code
follow the same style as the rest of the mach-shmobile stuff.

>> You may now ask why do I want to keep the code that way. One reason is
>> that adding new abstractions and functions for SoCs is pointless
>> unless we have multiple boards upstream using the same SoC code. Which
>> we don't really have.
>
>
>    It's not pointless if you look further into the future.

Further into the future is DT, and because of that there is no need to
optimize the C case. It's as simple as that. You are welcome to help
out with the DT bits.

>> So adding code following that style will just
>> bloat the code base.
>
>
>    I don't see any significant bloat, frankly.

I guess it's a matter of preference. In your case you add a function
prototype to the SoC header, add a special function, then call that
from the board. Even though there is only a single board. With that
you have to look at multiple places to find both platform data and
resources. It's not the same as the other SoCs and I dislike that.

For the single board case not doing that will save some lines and
remove pointless abstractions. If you have multiple boards for
upstream then we can of course reconsider. But until then it's all
pointless abstractions.

>> I do however think that sharing data in a more
>> efficient way is a good thing for the future, but I believe that
>> discussion should happen with DT reference implementations. So please
>> put your focus there if you want to improve things. The legacy C SoC
>> and board code is no place for innovation.
>
>
>    We weren't aware of that (somewhat dubious) policy before. You should
> have spoken much earlier.

Well, maybe so. But the person that implemented the r8a7778 could also
have followed the same style as the rest of the subarchitecture. I
can't see how that would be so difficult. Regardless it's no big deal
since we can easily move things around.

>> As you know, the legacy C code for r8a7778 at this point includes
>> various functions in the SoC code that introduces some alternative
>> more verbose way to deal with platform devices. This has been added
>> without changing the style for other SoCs under mach-shmobile.
>
>
>    Not true. We also changed R8A7779 code in the same way. We have no
> obligations from Renesas with regards to the other mach-shmobile code
> and we have no bandwidth for global cleanups.

So now you have 1.5 special case of out 8 SoCs. But I want them all to
be uniform.

>> This
>> means that the r8a7778 code is implemented differently than the other
>> SoCs. This becomes a nightmare for me since I'm pretty much the only
>> person who deals with tree wide changes and understands how the
>> MACHINE_START bits and the init order works for different cases.
>> Because of this I want all the legacy C SoC and board code to follow
>> the same style and behave the same way. Moving code around here just
>> for fun makes things difficult with no real upside IMO.
>
>
>> Morimoto-san has kindly helped me to rework the r8a7778 code into
>> something more standard which I really appreciate. Because of this I'm
>> going to ask Simon to merge his patches to make r8a7778 follow the
>> same style as the rest of mach-shmobile.
>
>
>    I'd like to hear replies to my unanswered questions first as
> Morimoto-san's seems to have gotten a habit of simply ignoring my questions.
> Also, I think his changelogs are not very adequate in the light of what you
> said here.

I don't know about the change logs. I think he is quite useful. He is
not very noisy and he doesn't NAK randomly. He also doesn't comment on
minor details.

>> If you want to help defining next generation board and SoC design then
>> please work with us how the DT reference SoC and board support should
>> look like.
>
>    We have our areas of work from Renesas for which we're paid (and to which
> Renesas periodically adds new tasks with higher priority), and typically
> have no bandwidth to work on something else. DT support is quite low in our
> priority lists, though it's definitely there.

Well, I thought so. I'm just staying that you can use your code rework
energy somewhere it really matters instead of simply moving platform
devices around.

Cheers,

/ magnus
