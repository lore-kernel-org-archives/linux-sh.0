From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 20 Mar 2014 12:24:23 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <532ADDF7.70601@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395256010-12222-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20/03/14 13:19, Laurent Pinchart wrote:
> Hi Geert,
>
> On Thursday 20 March 2014 13:13:28 Geert Uytterhoeven wrote:
>> On Thu, Mar 20, 2014 at 1:01 PM, Laurent Pinchart wrote:
>>> On Thursday 20 March 2014 09:56:17 Ben Dooks wrote:
>>>> On 19/03/14 20:06, Geert Uytterhoeven wrote:
>>>>> This patchset enables the PM runtime code in drivers/sh/pm_runtime.c
>>>>> when running a multi-platform ARM kernel including support for
>>>>> shmobile. Before this code was only enabled for legacy shmobile
>>>>> kernels, leading to disabled clocks in multiplatform kernels, depending
>>>>> on implicit reset state or on the bootloader.
>>>>>
>>>>>     [1/5] drivers: sh: pm_runtime does not need idle callback
>>>>>     [2/5] sh: intc: Restrict INTC_USERIMASK to SH4A
>>>>
>>>> I thought there was already a of capable intc driver in the
>>>> irq drivers directory?
>>>
>>> I think Ben's point is that drivers/sh/intc might be completely unneeded
>>> for ARM.
>>
>> http://www.spinics.net/lists/linux-sh/msg30067.html
>>
>> "Furthermore, the core intc parts are used by sh7372/mackerel and
>>   sh73a0/kzm9g (and arch/sh) only, so I'm gonna restrict it to
>>   ARCH_SHMOBILE_LEGACY and SUPERH only."
>
> My bad, sorry. If it wasn't for sh7372 and sh73a0 being old SoCs that's
> probably something we should fix by moving the code to drivers/irqchip.

Something to look at later?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
