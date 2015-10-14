From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 14 Oct 2015 08:09:51 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <CANqRtoQvGLZSRi1DyWT+ZBO+pGLjkAbbQHpxkFcxNKa1_3qrnA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Oct 14, 2015 at 4:54 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Oct 14, 2015 at 9:44 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Wed, Oct 14, 2015 at 4:07 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Wed, Oct 14, 2015 at 3:09 AM, Laurent Pinchart
>>> <laurent.pinchart@ideasonboard.com> wrote:
>>>>> Tested with a Lager board and using both I2C/IIC. Based on my testings in
>>>>> Dublin with a Koelsch board, I'd be very surprised if it fails with Koelsch.
>>>>> Laurent may prove me wrong ;)
>>>>
>>>> I've tried to reproduce the problem tonight and couldn't, even without your
>>>> recent i2c-rcar patches :-/ I'll keep running tests on Koelsch with that
>>>> configuration and make sure to report any issue I can find.
>>>
>>> The Koelsch that failed has a much newer U-Boot (b653737dfca2), which
>>> only enables the MSTP clocks that are really needed, while you and I have
>>> much older versions (I have b6af5fcc8dfc).
>>
>> With the new CPG-MSSR driver it should be possible to disable unused
>> MSTP clocks in the kernel during boot without too much trouble, right?
>> Of course it is not something that is needed right away, but DT
>> architecture wise it seems possible to squeeze that in without having
>> to update the DT binding.
>
> Unused clocks are already disabled by the clock framework, but that
> happens at late_initcall() time, i.e. after i2c probing.

Oh, right..

> Or do you mean disabling them upfront?
> There are some clocks that must not be disabled. Some of them are not
> documented.

Disabling them upfront with sparse documentation seems fun, but also a
bit like asking for trouble. =)

So disabling clocks upfront may be a troublesome but good way to
trigger incorrect dependencies, and unless I'm mistaken it should give
the same behaviour as the updated u-boot version, right?

Cheers,

/ magnus
