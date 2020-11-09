From: Rob Landley <rob@landley.net>
Date: Mon, 09 Nov 2020 16:34:52 +0000
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
Message-Id: <d0ed6336-e6a9-32d0-4970-09e811c97519@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
In-Reply-To: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/9/20 9:10 AM, Jens Axboe wrote:
> On 11/9/20 8:15 AM, Rob Landley wrote:
>>
>>
>> On 11/9/20 8:14 AM, Jens Axboe wrote:
>>> On 11/9/20 1:15 AM, Rob Landley wrote:
>>>> On 11/5/20 11:15 AM, Jens Axboe wrote:
>>>>> On 11/5/20 9:20 AM, John Paul Adrian Glaubitz wrote:
>>>>>> Hi Jens!
>>>>>>
>>>>>> On 11/5/20 5:17 PM, Jens Axboe wrote:
>>>>>>> Gentle nudge on this one.
>>>>>>
>>>>>> I can build- and boot-test on SH and IA64.
>>>>>
>>>>> That'd be great, thanks!
>>>>>
>>>>>> I assume Rich will be fine with the SH changes, not sure about the IA64 and Tony.
>>>>>
>>>>> Let's add Tony - maybe he'll have a chance to take a look at the ia64 change.
>>>>
>>>> It breaks my ARCH=sh j2_defconfig build:
>>>>
>>>> arch/sh/kernel/signal_32.c: In function 'do_signal':
>>>> arch/sh/kernel/signal_32.c:469:6: error: 'ti_work' undeclared (first use in this
>>>> function)
>>>>
>>>> Admittedly I'm testing a stack of 6 other patches at the same time:
>>>>
>>>> [PATCH -next v2] sh: intc: Convert to DEFINE_SHOW_ATTRIBUTE.eml
>>>> [PATCH] sh: dma: fix kconfig dependency for G2_DMA.eml
>>>> [PATCH] sh: remove CONFIG_IDE from most defconfig.eml
>>>> [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro.eml
>>>> [PATCH v1] sh: Drop ARCH_NR_GPIOS definition.eml
>>>> [PATCH v2 RESEND +TRIVIAL] arch_sh: hyphenate Non-Uniform in Kconfig prompt.eml
>>>>
>>>> But this is the one I need to revert to get 5.10-rc3 to build, the rest compile.
>>>
>>> Yeah that's my fault, this one should be a lot better...
>>
>> arch/sh/kernel/signal_32.c: In function 'do_signal':
>> arch/sh/kernel/signal_32.c:471:3: error: implicit declaration of function
>> 'tracehook_notify_signal'; did you mean 'tracehook_notify_resume'?
>> [-Werror=implicit-function-declaration]
>>
>> Keep 'em coming...
> 
> Gah, it was still using the old style. This one should work and be correct,
> promise, double checked :-)

This one compiled fine. What does it do? (I ask having read
https://lwn.net/Articles/835340/ and come out none the wiser.)

I can try it on hardware in the morning, it's 1am in this time zone...

Rob
