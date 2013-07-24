From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 04:45:36 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <CANqRtoT33WF1VPS4JVBt=a8sjBT=ELDF+T5dQCLsO_-seR6iQA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Sergei,

On Fri, Jul 12, 2013 at 8:05 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 12-07-2013 4:56, Simon Horman wrote:
>
>>>> sh_eth driver which needs platform data at the time of
>>>> registration is used from BockW only.
>>>> Now, ARM/shmobile aims to support DT,
>>>> and the C code base board support will be removed in the future.
>>>> The driver registration method which needs platform data
>>>> and which is not shared complicates codes.
>>>> This patch registers it on board code as cleanup C code
>
>
>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
>
>>>     NAK.
>
>
>> Please provide some reasoning for your objection to this change.
>> Likewise for other patches in this series to which you have replied
>> in the same manner. I for one do not understand what it is you object to.
>
>
>    Sorry, I was just out of words when I saw this. I for one do not
> understand how this change will help the DT support and to me it seems no
> more than a pointless churn and step backward from what we had. Under no
> circumstances I will accept this change -- I'm totally opposed to the idea
> of moving the SoC devices to the board code.

Thanks for emailing once more and explaining your reasons behind the
NAK. Please allow me to step in here and explain things a bit.

Originally on SH and ARM mach-shmobile we have divided platform
devices into two categories - SoC specific and board specific. As
expected, SoC specific devices go in setup-xxx.c and board specific
devices go into board-xxx.c. So far so good.

It may become a bit more unclear in some cases when part of the
platform device data is board specific but other parts are SoC
specific. Historically we have simply made those board specific. For
various reasons I'd like to keep the code that way.

You may now ask why do I want to keep the code that way. One reason is
that adding new abstractions and functions for SoCs is pointless
unless we have multiple boards upstream using the same SoC code. Which
we don't really have. So adding code following that style will just
bloat the code base. I do however think that sharing data in a more
efficient way is a good thing for the future, but I believe that
discussion should happen with DT reference implementations. So please
put your focus there if you want to improve things. The legacy C SoC
and board code is no place for innovation.

As you know, the legacy C code for r8a7778 at this point includes
various functions in the SoC code that introduces some alternative
more verbose way to deal with platform devices. This has been added
without changing the style for other SoCs under mach-shmobile. This
means that the r8a7778 code is implemented differently than the other
SoCs. This becomes a nightmare for me since I'm pretty much the only
person who deals with tree wide changes and understands how the
MACHINE_START bits and the init order works for different cases.
Because of this I want all the legacy C SoC and board code to follow
the same style and behave the same way. Moving code around here just
for fun makes things difficult with no real upside IMO.

Morimoto-san has kindly helped me to rework the r8a7778 code into
something more standard which I really appreciate. Because of this I'm
going to ask Simon to merge his patches to make r8a7778 follow the
same style as the rest of mach-shmobile.

If you want to help defining next generation board and SoC design then
please work with us how the DT reference SoC and board support should
look like.

Thanks,

/ magnus
