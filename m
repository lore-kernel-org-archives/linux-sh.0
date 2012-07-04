From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 04 Jul 2012 11:00:25 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <CANqRtoSdqUDNqtH2a97zhCf7e3g_i9N2VVuFU+Rw3=22=5DTSw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 4, 2012 at 7:53 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Wed, 4 Jul 2012, Paul Mundt wrote:
>
>> On Wed, Jul 04, 2012 at 07:41:09PM +0900, Magnus Damm wrote:
>> > On Wed, Jul 4, 2012 at 7:38 PM, Mark Brown
>> > <broonie@opensource.wolfsonmicro.com> wrote:
>> > > On Wed, Jul 04, 2012 at 12:40:56PM +0200, Rafael J. Wysocki wrote:
>> > >
>> > >> Well, if arch-wide, then perhaps we don't need REGULATOR_FIXED_VOLTAGE at all
>> > >> and we can just make things depending on it depend on REGULATOR directly?
>> > >
>> > >> The meaning of what you're proposing above is pretty much
>> > >> "REGULATOR_FIXED_VOLTAGE should be set whenever REGULATOR is" and I guess
>> > >> REGULATOR_FIXED_VOLTAGE depends on REGULATOR, so they appear to be equivalent.
>> > >
>> > >> How much code does really depend on REGULATOR_FIXED_VOLTAGE which is not build
>> > >> when REGULATOR is set?
>> > >
>> > > No, that won't help - the problem is that we want a specific regulator
>> > > driver to be built in order to ensure that the services it provides are
>> > > available.
>> >
>> > Right, so what's wrong with having a "select REGULATOR_FIXED_VOLTAGE"
>> > on boards that make use of them? That seems to be the most
>> > straightforward way to me.
>> >
>> Yes, agreed. This is not very different from the gpiolib have/want case,
>> either, and going that on a board-specific level worked out fine.
>
> Ok, I'll make 2 patches then - for arch/sh/boards/Kconfig and
> arch/arm/mach-shmobile/Kconfig, adding the proposed "select ... if ..."
> line for each affected board.

Thanks. Is the "if ..." part the preferred way? It seems very verbose to me.

Cheers,

/ magnus
