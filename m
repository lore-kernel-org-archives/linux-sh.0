From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 26 Aug 2016 09:04:57 +0000
Subject: Re: [PATCH v6 2/2] clocksource: add J-Core timer/clocksource driver
Message-Id: <57C00639.7060509@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.147018b3518.git.dalias@libc.org>
 <f127e6d3f3ef64ea286b7b8f485e5d0c7f3faa6f.147018b3518.git.dalias@libc.org>
 <57BDCE5D.2050609@linaro.org> <20160824174001.GW15995@brightrain.aerifal.cx>
In-Reply-To: <20160824174001.GW15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <Marc.Zyngier@arm.com>

On 08/24/2016 07:40 PM, Rich Felker wrote:

[ ... ]

>>> +config CLKSRC_JCORE_PIT
>>> +	bool "J-Core PIT timer driver"
>>> +	depends on OF && (SUPERH || COMPILE_TEST)
>>
>> Even if this is correct, for the sake of consistency, it is preferable
>> to change it to:
>>
>> 	bool "J-Core PIT timer driver" if COMPILE_TEST
>> 	depends on SUPERH
>> 	select CLKSRC_OF
>=20
> Is this functionally equivalent? If so that's non-obvious to me. What
> about the dropped OF dependency? The intent is that the option should
> always be available for SUPERH targets using OF, otherwise only
> available with COMPILE_TEST.ig

It is not equivalent but consistent with the other options where it is
not possible to manually set/unset the driver config wuthout COMPILE_TEST.

>>> +static int jcore_pit_set(unsigned long delta, struct jcore_pit *pit)
>>> +{
>>> +	jcore_pit_disable(pit);
>>> +	__raw_writel(delta, pit->base + REG_THROT);
>>> +	__raw_writel(pit->enable_val, pit->base + REG_PITEN);
>>> +	return 0;
>>
>> Why do you need to use __raw_writel ?
>>
>> s/__raw_writel/writel/
>=20
> I actually tried multiple times to find good resources on policy for
> which form to prefer, but didn't have much luck. My understanding is
> that __raw_writel/__raw_readl always performs a native-endian
> load/store, whereas writel/readl behavior depends on cpu endianness
> and whether the arch declares that "pci bus" (that was the term I
> found in the source, not relevant here) io is endian-swapped or not.
> Can you give me a better explanation of why we might prefer one form
> or the other?

[ skipping this as it was very well commented by Arnd and Mark ]

>>> +	freq =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, buspd);
>>> +	pit->periodic_delta =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ*buspd);
>>
>> --->					HZ * buspd
>=20
> OK.
>=20
>>> +	clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int jcore_pit_local_shutdown(unsigned cpu)
>>> +{
>>> +	return 0;
>>> +}
>>
>> This function is useless I think. AFAIU, cpuhp_setup_state can have a
>> NULL function for the cpu teardown.
>=20
> OK, I wasn't sure if that was permitted.
>=20
>>> +	jcore_cs.name =3D "jcore_pit_cs";
>>> +	jcore_cs.rating =3D 400;
>>> +	jcore_cs.read =3D jcore_clocksource_read;
>>> +	jcore_cs.mult =3D 1;
>>> +	jcore_cs.shift =3D 0;
>>> +	jcore_cs.mask =3D CLOCKSOURCE_MASK(32);
>>> +	jcore_cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
>>> +
>>> +	err =3D clocksource_register_hz(&jcore_cs, NSEC_PER_SEC);
>>> +	if (err) {
>>> +		pr_err("Error registering clocksource device: %d\n", err);
>>> +		return err;
>>> +	}
>>
>> May be you can consider by replacing the above by:
>>
>> 	clocksource_mmio_init(jcore_pit_base, "jcore_pit_cs",
>> 				NSEC_PER_SEC, 32,
>> 				jcore_clocksource_read);
>=20
> I think you're missing the rating argument. Otherwise it should work,
> but is there a good reason to prefer it? The code is slightly simpler;
> I'm not sure if using kzalloc vs static storage is better or worse.

Probably clksrc field pointers are pre-calculated at compile time while
the allocation results in the code into an indirection to compute the
pointers, but I don't think it is noticeable.

[ ... ]

>>> +	/*
>>> +	 * The J-Core PIT is not hard-wired to a particular IRQ, but
>>> +	 * integrated with the interrupt controller such that the IRQ it
>>> +	 * generates is programmable. The programming interface has a
>>> +	 * legacy field which was an interrupt priority for AIC1, but
>>> +	 * which is OR'd onto bits 2-5 of the generated IRQ number when
>>> +	 * used with J-Core AIC2, so set it to match these bits.
>>> +	 */
>>> +	hwirq =3D irq_get_irq_data(pit_irq)->hwirq;
>>
>> 	irq_hw_number_t hwirq;
>> 	hwirq =3D irqd_to_hwirq(irq_get_irq_data(pit_irq));
>=20
> OK.
>=20
>>> +	irqprio =3D (hwirq >> 2) & PIT_PRIO_MASK;
>>> +	enable_val =3D (1U << PIT_ENABLE_SHIFT)
>>> +		   | (hwirq << PIT_IRQ_SHIFT)
>>> +		   | (irqprio << PIT_PRIO_SHIFT);
>>
>>
>> I'm missing the connection between the description above and the enable
>> value computed here. Can you elaborate ?
>=20
> The irqprio field is filled in using a value that matches bits 2 and
> up of hwirq; this is what the comment says and what the code does. Can
> you elaborate on what you don't understand?

The API to compute the 'enable_val'.

Having a technical reference manual would help a lot.

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

