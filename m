From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 10 Jun 2011 05:03:43 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 gic_arch_extn.irq_set_wake() fix
Message-Id: <BANLkTinWFByQJ6vWx=UR2ZL8dE2vDaK9kg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609062003.383.67447.sendpatchset@t400s>
In-Reply-To: <20110609062003.383.67447.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, Jun 10, 2011 at 11:20 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Jun 09, 2011 at 03:20:03PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Initialize ->irq_set_wake() in gic_arch_extn to unbreak wake
>> up from the KEYSC device on AG5EVM in case of Suspend-to-RAM.
>>
>> Without this patch "echo mem > /sys/power/state" and a key
>> press results in the following message on resume:
>>
>> WARNING: at kernel/irq/manage.c:507 irq_set_irq_wake+0x7c/0xd8()
>> Unbalanced IRQ 103 wake disable
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>> ---
>>
>> =A0arch/arm/mach-shmobile/intc-sh73a0.c | =A0 =A06 ++++++
>> =A01 file changed, 6 insertions(+)
>>
>> --- 0001/arch/arm/mach-shmobile/intc-sh73a0.c
>> +++ work/arch/arm/mach-shmobile/intc-sh73a0.c 2011-06-08 18:42:14.000000=
000 +0900
>> @@ -250,6 +250,11 @@ static irqreturn_t sh73a0_intcs_demux(in
>> =A0 =A0 =A0 return IRQ_HANDLED;
>> =A0}
>>
>> +static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
>> +{
>> + =A0 =A0 return 0; /* always allow wakeup */
>> +}
>> +
>
> I wonder if a more generic location and name for this would be worthwhile.
> It seems to me that that other hardware may also want to do this.

Not so sure about that. It all depends on what other hardware
platforms need to do in their sleep code. Do you have any particular
hardware platform in mind?

Without this callback in place set_irq_wake_real() will return -ENXIO.
Which is fine if you don't support Suspend-to-RAM with IRQ wake up. On
sh73a0 we do support Suspend-to-RAM in linux-3.0-rc and without this
patch we trigger a warning. So to properly support sh73a0 in 3.0-rc we
need some kind of fix.

For now we don't implement deep enough sleep modes to require any
special code in sh73a0_set_wake(). In the future we want to add more
advanced sleep modes, which will require us to extend the
sh73a0_set_wake() function.

Other SH and SH-Mobile ARM SoCs use INTC as interrupt controller
instead of GIC. This kind of fix is not needed for those SoCs.

/ magnus
