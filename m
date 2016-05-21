From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2016 18:07:54 +0000
Subject: Re: [PATCH v2 03/12] of: add J-Core interrupt controller bindings
Message-Id: <CAMuHMdUxQQt7E_mFscKh3t5ewTs=gKkV3OjZnK+Xq6AkbGZGyQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
	<2bdca4260d5bb2b3820e4309e2ba445c4c7bfbf6.1463708766.git.dalias@libc.org>
	<CAMuHMdVs9=8BGwmCBuYch2abJBnCLKoEx7i3EMghW3UUjXc7dA@mail.gmail.com>
	<20160520223456.GV21636@brightrain.aerifal.cx>
In-Reply-To: <20160520223456.GV21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Cooper <jason@lakedaemon.net>, Kumar Gala <galak@codeaurora.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Sat, May 21, 2016 at 12:34 AM, Rich Felker <dalias@libc.org> wrote:
> On Fri, May 20, 2016 at 10:04:26AM +0200, Geert Uytterhoeven wrote:
>> On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
>> > +Additional properties required for aic1:
>> > +
>> > +- reg : Memory region for configuration.
>> > +
>> > +- cpu-offset : For SMP, the offset to the per-cpu memory region for
>> > +  configuration, to be scaled by the cpu number.
>>
>> Does cpu-offset apply to aic1 only?
>
> The current kernel driver doesn't have any reason to _need_ cpu-offset
> for aic2, but since there are registers there that a driver (even a
> non-Linux one) may want to use, I think it makes sense that it should
> be present in the bindings.

Hence the "for aic1" should be dropped?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
