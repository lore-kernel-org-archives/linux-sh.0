From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Mar 2014 16:48:37 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <CANqRtoQwG3j0LZtQH1uHWnwC4LC0=U7o9ib8WnMaSQL9W5ZOpw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ben,

On Sat, Mar 15, 2014 at 12:51 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> On 14/03/14 12:39, Geert Uytterhoeven wrote:
>>
>> Hi Ben, Laurent,
>>
>> On Fri, Mar 14, 2014 at 12:10 PM, Ben Dooks <ben.dooks@codethink.co.uk>
>> wrote:
>>>
>>> On 14/03/14 11:02, Laurent Pinchart wrote:
>>>>
>>>> On Thursday 13 March 2014 15:29:30 Geert Uytterhoeven wrote:
>>>>>
>>>>> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>>>>>
>>>>> Due to issues with runtime PM clock management, clocks not explicitly
>>>>> managed by their drivers may not be enabled at all, or be inadvertently
>>>>> disabled by the clk_disable_unused() late initcall.
>>>>>
>>>>> Until this is fixed, add a temporary workaround, calling
>>>>> shmobile_clk_workaround() with enable = true.
>>>>>
>>>>> For now this enables the clocks for: ether, i2c2, msiof0, qspi_mod, and
>>>>> thermal. More clocks can be added if needed.
>>>>
>>>>
>>>> This should do the job, but as you mentioned, it's a crude hack. As
>>>> we're
>>>> targeting v3.16, is there a chance we could fix the problem properly
>>>> instead ?
>>
>>
>> Of course the goal is to fix it for real, so the crude hack will no longer
>> be needed. But for now, it looks like a good short-term workaround.
>>
>>> The best fix would be to re-enable the PM and find out what is
>>
>>
>> Sure, but in a multiplatform-aware way.
>>
>>> actually causing the external abort. However currently there is
>>> no information in the manuals about anything we could find out from
>>> the AXI busses as to what the source actually is.
>>
>>
>> I re-applied your patch "ARM: shmobile: compile drivers/sh for
>> CONFIG_ARCH_SHMOBILE_MULTI", and surprisingly, I no longer get
>> the external abort.
>>
>> Some experimenting revealed it's due to the "ether" clock in the
>> clk_enables[] array. As long as that's enabled early, the system seems
>
>
> I did post an updated to ensure the MDIO bus is accessed with clock
> enabled, but that has not cured the issue for me. I wonder if some
> other part of the driver is also accessing the hardware without
> the correct pm accesses.

That would not surprise me. But it would trigger both for
multiplatform and legacy in such case, don't you think?

If static enablement using the clock workaround fixes the
multiplatform case then it is most likely related to that the driver
assumes that Runtime PM controls the clock. Or perhaps some hidden
clock dependency that only triggers with CCF?

Thanks,

/ magnus
