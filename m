From: Jens Axboe <axboe@kernel.dk>
Date: Mon, 09 Nov 2020 16:29:28 +0000
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
Message-Id: <1222fc17-dc3b-5def-e9c1-743b2436d6d7@kernel.dk>
List-Id: <linux-sh.vger.kernel.org>
References: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
In-Reply-To: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 11/9/20 9:34 AM, Rob Landley wrote:
> On 11/9/20 9:10 AM, Jens Axboe wrote:
>> On 11/9/20 8:15 AM, Rob Landley wrote:
>>>
>>>
>>> On 11/9/20 8:14 AM, Jens Axboe wrote:
>>>> On 11/9/20 1:15 AM, Rob Landley wrote:
>>>>> On 11/5/20 11:15 AM, Jens Axboe wrote:
>>>>>> On 11/5/20 9:20 AM, John Paul Adrian Glaubitz wrote:
>>>>>>> Hi Jens!
>>>>>>>
>>>>>>> On 11/5/20 5:17 PM, Jens Axboe wrote:
>>>>>>>> Gentle nudge on this one.
>>>>>>>
>>>>>>> I can build- and boot-test on SH and IA64.
>>>>>>
>>>>>> That'd be great, thanks!
>>>>>>
>>>>>>> I assume Rich will be fine with the SH changes, not sure about the =
IA64 and Tony.
>>>>>>
>>>>>> Let's add Tony - maybe he'll have a chance to take a look at the ia6=
4 change.
>>>>>
>>>>> It breaks my ARCH=3Dsh j2_defconfig build:
>>>>>
>>>>> arch/sh/kernel/signal_32.c: In function 'do_signal':
>>>>> arch/sh/kernel/signal_32.c:469:6: error: 'ti_work' undeclared (first =
use in this
>>>>> function)
>>>>>
>>>>> Admittedly I'm testing a stack of 6 other patches at the same time:
>>>>>
>>>>> [PATCH -next v2] sh: intc: Convert to DEFINE_SHOW_ATTRIBUTE.eml
>>>>> [PATCH] sh: dma: fix kconfig dependency for G2_DMA.eml
>>>>> [PATCH] sh: remove CONFIG_IDE from most defconfig.eml
>>>>> [PATCH] sh: Remove unused HAVE_COPY_THREAD_TLS macro.eml
>>>>> [PATCH v1] sh: Drop ARCH_NR_GPIOS definition.eml
>>>>> [PATCH v2 RESEND +TRIVIAL] arch_sh: hyphenate Non-Uniform in Kconfig =
prompt.eml
>>>>>
>>>>> But this is the one I need to revert to get 5.10-rc3 to build, the re=
st compile.
>>>>
>>>> Yeah that's my fault, this one should be a lot better...
>>>
>>> arch/sh/kernel/signal_32.c: In function 'do_signal':
>>> arch/sh/kernel/signal_32.c:471:3: error: implicit declaration of functi=
on
>>> 'tracehook_notify_signal'; did you mean 'tracehook_notify_resume'?
>>> [-Werror=3Dimplicit-function-declaration]
>>>
>>> Keep 'em coming...
>>
>> Gah, it was still using the old style. This one should work and be corre=
ct,
>> promise, double checked :-)
>=20
> This one compiled fine. What does it do? (I ask having read
> https://lwn.net/Articles/835340/ and come out none the wiser.)

The motivation is in another patch:

https://git.kernel.dk/cgit/linux-block/commit/?h=3Dtif-task_work&id=FDb5f02=
7ce662d1e10d8d16793b1f588b8543277

Basically it decouples TWA_SIGNAL task_work from actual signals, since
they contend on the sighand lock, particularly for threads. Hence the
goal is to get all archs supporting TIF_NOTIFY_SIGNAL, so we can use
that for TWA_SIGNAL.

The patches are done such that the signal handling core still handles
running the task_work, but if invoked without TIF_SIGPENDING, we don't
do actual signal delivery, just the syscall restart part.

> I can try it on hardware in the morning, it's 1am in this time zone...

Thanks, that'd be great! It really should be a no-op, as you can see
from the final patch, it's just masking in an extra flag for when to
call get_signal(). At least it should've been, if I hadn't neglected
to properly updated the 'sh' patch for the cleaner setup...

--=20
Jens Axboe
