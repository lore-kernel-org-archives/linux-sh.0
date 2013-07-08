From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 08:43:33 +0000
Subject: Re: [PATCH v2 3/4] ARM: shmobile: ape6evm-reference: add CPUFreq support
Message-Id: <CANqRtoRvNsxqgD+fyaWk+FC5JdzOH=iwWiaBZKFM1nBaYyNBww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 8, 2013 at 5:00 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Mon, 8 Jul 2013, Guennadi Liakhovetski wrote:
>
> [snip]
>
>> Or have I misunderstood? As for your other idea:
>>
>> <quote>
>> Also, in parallel with platform device in C board
>> code you should add DT nodes for the DT reference board support.
>> </quote>
>>
>> Do you mean adding that "cpufreq-cpu0" device from DT? That's (currently)
>> impossible. The cpufreq-cpu0.c driver doesn't have an .of_match_table
>> field. Since otherwise this is a DT-specific driver - it parses CPU0 DT
>> data - I don't think that was an oversight of the author, instead it must
>> have been their conscious decision. Exact reasons are unknown to me.
>
> Ok, I think, I know why. Probably, because that "device" doesn't describe
> "real hardware," instead, it's just a driver activation helper.

Well, it is most likely a software application configuration thing
hidden as a platform device, so obviously it should not be described
via DT.

But regardless of that:
- I don't want it called from DT_MACHINE in setup-xxx.c
(It is not a SoC-specific thing, so don't make my SoC code ugly, solve
it in a generic way instead)

- I don't want you to add tiny functions and header files that just
result in a single line of code.
(Call it directly from the DT reference board code until you figure
out how to do it in a generic way)

Thanks,

/ magnus
