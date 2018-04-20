From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 20 Apr 2018 15:43:01 +0000
Subject: Re: [PATCH] sh: time: Remove the read_persistent_clock()
Message-Id: <CAK8P3a3r3wZ_K2UXTQ12gUk_ioC_tg3AMxYvp83WY0ds3t0y5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <c52709fe323b56916b3f621dac1baf6d49225188.1524117883.git.baolin.wang@linaro.org>
In-Reply-To: <c52709fe323b56916b3f621dac1baf6d49225188.1524117883.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 20, 2018 at 5:32 PM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Apr 20, 2018 at 05:19:43PM +0200, Arnd Bergmann wrote:
>> On Thu, Apr 19, 2018 at 8:06 AM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> > The read_persistent_clock() uses a timespec, which is not year 2038 safe
>> > on 32bit systems. Moreover on sh platform, we have RTC drivers that can
>> > be used to compensate the system suspend time. Thus we can remove the
>> > read_persistent_clock() safely.
>> >
>> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>
>> Hi Baolin and sh maintainers.
>>
>> I have done a similar patch but never got around to posting it. Please
>> see my patch below.
>>
>> Note that the patch is whitespace broken, I can send a proper
>> version to the sh maintainers if they want to merge it, or I can
>> apply my patch to my y2038 tree myself.
>>
>>        Arnd
>>
>> commit cade6829ca223d9761863e74595d677b3dc14ecd
>> Author: Arnd Bergmann <arnd@arndb.de>
>> Date:   Wed Jan 24 16:18:50 2018 +0100
>>
>>     sh: remove unused rtc_sh_get/set_time infrastructure
>>
>>     All platforms are now converted to RTC drivers, so this has become
>>     obsolete. The board_time_init() callback still has one caller, but
>>     could otherwise also get killed.
>>
>>     This removes one more usage of the deprecated timespec structure,
>>     which overflows in y2038.
>>
>>     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> In principle this looks correct, but I don't think all the drivers
> have been converted. I did a quick grep for where board_time_init is
> set, and found mach-dreamcast and mach-sh03 boards have rtc drivers
> that set rtc_sh_[gs]et_time pointers. These need to be converted to
> proper rtc drivers, I think.

Ah, of course. I fished the one patch out of my stash of unsubmitted
patches, but missed the fact that I had three of them, the other ones
converting sh03 and dreamcast, respectively. ;-)

Let me send all three for proper review then.

> The of-generic board also uses board_time_init, but only to call the
> arch-independent timer_probe which uses devicetree to get
> clocksource/clockevent devices. This probe should probably be moved to
> the place where board_timer_init is called, right?

Good idea. My patches don't do that, but that seems like a
good follow-up.

      Arnd
