From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Aug 2009 14:18:13 +0000
Subject: Re: [PATCH 3/3] Add FSI-AK464x sound support for ms7724se
Message-Id: <aec7e5c30908190718j40459a55w614093c6366800db@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uiqgk59lj.wl%morimoto.kuninori@renesas.com>
	 <20090819120058.GB20227@rakim.wolfsonmicro.main>
	 <aec7e5c30908190646l1af450e8w3178683893a17437@mail.gmail.com>
	 <20090819140256.GA31305@rakim.wolfsonmicro.main>
In-Reply-To: <20090819140256.GA31305@rakim.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, lethal@linux-sh.org, Takashi Iwai <tiwai@suse.de>

On Wed, Aug 19, 2009 at 11:02 PM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Wed, Aug 19, 2009 at 10:46:34PM +0900, Magnus Damm wrote:
>> On Wed, Aug 19, 2009 at 9:00 PM, Mark
>> Brown<broonie@opensource.wolfsonmicro.com> wrote:
>
>> >> + =A0 =A0 gpio_request(GPIO_FN_FSIMCKA, =A0 =A0NULL);
>
>> > Is this something that the FSI driver should do for itself? =A0It looks
>> > like there's no pin options here, just fixed functions for FSI A or B =
so
>> > replicating per-board seems redundant. =A0On the other hand, if it's
>> > idiomatic for SH better keep it this way.
>
>> These GPIO_FN_ values are processor specific, sh7724 in this case. I
>> suspect we will see the FSI block reused in future processors so
>> keeping processor-specific bits out of the driver itself may be a good
>> plan. Long term I'd be more than happy to pass along processors
>> specific GPIOs to each driver, but at this point I don't know any
>> clean and standard way to do that.
>
> Is it possible to build kernels for more than one processor? =A0The way
> the code looks that's not the case...

At this point on SuperH we first select processor and then board(s)
after that. So the kernel is configured to run on one specific
processor model. But the FSI block may show up in other processors and
the pinmux configuration will most likely be different at that point.
We usually keep the pinmux configuration in the board setup code and
the let the driver "just work" and never touch any GPIOs unless the
driver comes with GPIO support.

Does it make sense? =3D)

/ magnus
