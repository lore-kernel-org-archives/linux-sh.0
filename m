From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Mar 2014 15:27:19 +0000
Subject: Re: [PATCH] ARM: shmobile: Add Lager clock workarounds for SDHI and MMCIF
Message-Id: <CAMuHMdUJEA5MRYAt3F1hHppadgA94GHmx-8vzY1ZMQG3vEMg9Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140318125247.21670.94176.sendpatchset@w520>
In-Reply-To: <20140318125247.21670.94176.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben et al,

On Tue, Mar 18, 2014 at 3:31 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 18/03/14 15:01, Laurent Pinchart wrote:
>> On Tuesday 18 March 2014 14:48:36 Ben Dooks wrote:
>>> On 18/03/14 14:25, Laurent Pinchart wrote:
>>>> On Tuesday 18 March 2014 21:52:47 Magnus Damm wrote:
>>>>> From: Magnus Damm <damm@opensource.se>
>>>>>
>>>>> Add MMCIF1, SDHI0 and SDHI2 to the clock workaround list for
>>>>> Lager multiplatform. Without these additional lines wakeup
>>>>> from Suspend-to-RAM never happens.
>>>>
>>>> What about fixing the root cause instead of piling up hacks ?
>>>
>>> See RFC to move the drivers/sh/pm_runtime.c out of drivers/sh.
>>
>> I wasn't sure whether the problem that this patch tries to work around was
>> related to runtime PM as it wasn't mentioned in the commit message.
>>
>>> I need to address the issue that the code does not actually allow any
>>> devices to PM.
>>
>> I've replied to your RFC and have studied the issue further since then.
>>
>> First of all, I think we should get Rafael Wysocki and Felipe Balbi in the
>> loop, as Rafael is probably the reference person for runtime PM, and
>> Felipe
>> has submitted an alternative proposal to manage device clocks
>> automatically.
>
> I thought Felipes was pretty much what was already implemented in the
> drivers/base/power/clock_ops.c driver?

There are some similarities...

>> Then, just copying the drivers/sh/pm-runtime.c over to drivers/base/
>> doesn't
>> seem to be a good idea to me. Core infrastructure code in drivers/base/
>> needs
>> to be properly documented, and thus properly understood. I feel like we're
>> rushing thing, taking code that seem to work but that isn't really
>> understood,
>> and turning it into core code.
>
> It does not need to be moved there, it would probably be better off
> having drivers/sh bein build and at-least fixing the two issues with
> the drivers/sh/pm_runtime.c
>
>> I think we should take a step back here, understand exactly what we're
>> doing,
>> and write documentation.
>
> I would suggest that we build drivers/sh/runtime_pm.c for the
> multiplatform case and add initialsiation calls from the relevant
> arch setup files in arch/arm/mach-shmobile.
>
> Once this is done we can then look at fixing the issues with making
> some generic code.

I agree with Laurent that we should fix the root cause, and that moving
drivers/sh/runtime_pm.c to drivers/base without a full understanding of
the ramifications is not a good idea.

I also agree with Ben that we can fix and enable drivers/sh/runtime_pm.c
for the multi-platform case as a short-term solution, until we have a proper
understanding, and have fixed the root cause in a way acceptable for all
parties.

May I also emphasize that, while we may not understand drivers/sh/runtime_pm.c
100% yet, this code has been in active use for a while.
FWIW, disabling it in a -legacy kernel also leads to disabled clocks.

Now, back to the "understanding" part...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
