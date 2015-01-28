From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Jan 2015 13:49:19 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
Message-Id: <CANqRtoRz17Etok2NE=MruE_akyOHtN+zDrhp1PWjubnLUvro5g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150128124645.21199.99590.sendpatchset@little-apple>
In-Reply-To: <20150128124645.21199.99590.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Jan 28, 2015 at 10:34 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Jan 28, 2015 at 1:46 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
>> domain."), the APE6EVM legacy board support is known to be broken.
>>
>> The IRQ numbers of the GIC are now virtual, and no longer match the
>> hardcoded hardware IRQ numbers in the legacy platform board code.
>>
>> To fix this issue specific to non-muliplatform r8a73a4 and APE6EVM:
>>  1) Instantiate the GIC from platform board code and also
>>  2) Skip over the DT arch timer as well as
>>  3) Force delay setup based on DT CPU frequency
>>
>> With these 3 fixes in place interrupts on APE6EVM are now unbroken.
>>
>> Partially based on legacy GIC fix by Geert Uytterhoeven, thanks to
>> him for the initial work.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>
> Thanks!
>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you!

> BTW, has anything tested lager-legacy with v3.19-rcX?
> We forgot about it as its removal is queued, but it's probably affected, too
> (.init_irq is not set, and board-lager.c uses irq numbers in platform devices).

Good point. I'm afraid I have not tested that one. I thought they were
gone since long!

To be honest, it seems kind of low priority since we should have
working multiplatform support for that board anyway. Compared to
r8a73a4 and APE6EVM where no multiplatform is available Lager and
Koelsch must be in much better state.

Cheers,

/ magnus
