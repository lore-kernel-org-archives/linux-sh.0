From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 20 Aug 2014 14:39:56 +0000
Subject: Re: [PATCH 01/06] ARM: shmobile: Consolidate GPIOLIB Kconfig bits
Message-Id: <CANqRtoTc+dhRAZXNGP4ij-HXu41cvinHXPtoksj2UXF_JcDs4w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140820133134.808.38907.sendpatchset@w520>
In-Reply-To: <20140820133134.808.38907.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Wed, Aug 20, 2014 at 10:50 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Wed, Aug 20, 2014 at 3:31 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> Consolidate ARCH_WANT_OPTIONAL_GPIOLIB under ARCH_SHMOBILE
>> so it can be shared by Legacy and Multiplatform.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  arch/arm/mach-shmobile/Kconfig |    9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> --- 0001/arch/arm/mach-shmobile/Kconfig
>> +++ work/arch/arm/mach-shmobile/Kconfig 2014-08-19 21:46:43.000000000 +0900
>> @@ -1,5 +1,6 @@
>>  config ARCH_SHMOBILE
>>         bool
>> +       select ARCH_WANT_OPTIONAL_GPIOLIB
>
> This is already selected by ARCH_MULTIPLATFORM, so perhaps it's best
> to just move it ARCH_SHMOBILE_LEGACY instead?
>
>>  menuconfig ARCH_SHMOBILE_MULTI
>>         bool "Renesas ARM SoCs" if ARCH_MULTI_V7

Uhm, yeah we seem to have some redundancy. Historically with the
legacy code we always started with OPTIONAL_GPIOLIB for SoCs then let
boards opt-in on REQUIRE_GPIOLIB if they actually depend on
programming the PFC/GPIO for normal operation. With Multiplatform it
becomes a more of a system-wide selection, so OPTIONAL indeed seems
something mainly useful for the Legacy case.

To make things more complicated, there are probably more bits under
ARCH_SHMOBILE_LEGACY that wants to be consolidated. Also ARM building
blocks like Cortex-A7, A8, A9, A15 could share common definitions, but
those look like common ARM architecture things to me.

I somehow feel reluctant of poking around in arch/arm/Kconfig and
potentially cause conflicts. But I guess that's the only way.

Cheers,

/ magnus
