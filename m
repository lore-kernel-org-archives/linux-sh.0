From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 26 Aug 2014 09:28:31 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: Consolidate Legacy GPIOLIB Kconfig bits
Message-Id: <CANqRtoR91NGG7oABzFbGk2hg_vRfWzeHqzYdKO0X=uk8UQ2jog@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140825034559.9316.68303.sendpatchset@w520>
In-Reply-To: <20140825034559.9316.68303.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Mon, Aug 25, 2014 at 5:39 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Mon, Aug 25, 2014 at 5:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Consolidate ARCH_WANT_OPTIONAL_GPIOLIB under ARCH_SHMOBILE_LEGACY
>> so it can be shared by the legacy ARM mach-shmobile code.
>
> Given
>   - all legacy support for shmobile boards except ape6evm, koelsch, and lager
>     select ARCH_REQUIRE_GPIOLIB,
>   - the ape6evm, koelsch, and lager defconfigs have CONFIG_GPIOLIB=y,
> shouldn't we just upgrade from ARCH_WANT_OPTIONAL_GPIOLIB
> to ARCH_REQUIRE_GPIOLIB?

Sure, that is fine with me. I'm not sure if there is much point in
separating OPTIONAL and REQUIRE anymore.

Historically in case of legacy support code we let the SoC code
provide ARCH_WANT_OPTIONAL_GPIOLIB and then allow each board to
override with ARCH_REQUIRE_GPIOLIB in case they require PFC or GPIO.
The idea was that boards that need to configure the pin controller
would select REQUIRE, but this was done ages before PINCTRL existed
and we relied on GPIO for pin mux configuration. Boards that only
relied on pin controller settings from the boot loader would rely on
OPTIONAL (by not selecting REQUIRE) which would allow the user to not
compile in GPIO support.

These days we use PINCTRL for pin mux configuration anyway, so with
that in mind perhaps there is not much point with these GPIO bits..

Cheers,

/ magnus
