From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 07:36:27 +0000
Subject: Re: [PATCH 00/08] ARM: shmobile: Suspend on non-SMP update for r8a7790
Message-Id: <CANqRtoSsfAQ8_ywX6ot27YDa2An4hGF+39ormc=C18NPBdUa-w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605051505.18075.76727.sendpatchset@w520>
In-Reply-To: <20140605051505.18075.76727.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Fri, Jun 6, 2014 at 4:08 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Fri, Jun 6, 2014 at 8:49 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> To try to improve the situation I'm considering adding a single setup
>> function for mach-shmobile. I was playing around with a similar
>> approach earlier but I could at that time not get any positive
>> comments about setting up the smp_ops dynamically. In general I think
>> it makes sense to setup a lot of similar callbacks from C instead of
>> explicitly adding them to each and every SoC and board mach vector.
>> Perhaps we could also deal with UP vs SMP at the same time?
>>
>> The idea with the code below would be to allow passing two pointers to
>> the setup code:
>> 1) function pointer for UP case
>> 2) smp_ops pointer for SMP setup case
>>
>> The setup function (shmobile_init_cpus() below) would be responsible
>> for the following:
>> - if running as smp then register the smp_ops
>> - if running as up then call the function pointer for setup
>> - execute shmobile_init_delay()
>> - install shmobile_init_late in the machine vector
>>
>> For the common case every machine vector we would only need dt_compat
>> and init_early.
>>
>> What do you think?
>
> Sounds reasonable.
>
> However, I had a quick look at the code, and am no longer that positive
> about it:
>   - .init_late() is too late to register the SMP ops, that's why there's a
>     .smp pointer, which is used much earlier (see setup_arch()),

Yes, ->smp_init() and smp_ops->smp_init_cpus() may get called early
on. We do however not rely on those for any of our SMP code.

>   - The machine vector is const, so you cannot install a handler later,

Ah, right, the smp_ops portion is handled as a special case. So
installing other callbacks seems unlikely.

>   - In the end, you would basically replace the current machine vector
>     callback scheme (which is data) by setup functions (which are code),
>     which is moving away from what the machine vector was originally
>     intended for?

Well, I've noticed a trend which is removing stuff from the machine
vector and replacing with run time installation. Good or bad.

smp_set_ops() is one such case. set_handle_irq() is another.

> Anyway, if you want to go this way, it needs discussion on the ARM kernel
> mailing list.

I agree, but I was hoping for something more short term... Just simply
trying to fix things that are broken take ages unfortunately. This
means we have to hold off for a couple of months at least
dependency-wise.

Cheers,

/ magnus
