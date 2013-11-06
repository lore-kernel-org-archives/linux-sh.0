From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Nov 2013 09:15:33 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: lager-reference: Switch to multiplaform
Message-Id: <CANqRtoQNCdLov+aeJkbfXdJ1wqazk5-KDGEZjQYgio22n2xKTQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383059082-26315-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383059082-26315-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon, Laurent,

On Wed, Nov 6, 2013 at 5:23 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Oct 29, 2013 at 04:04:37PM +0100, Laurent Pinchart wrote:
>> Move the Lager reference board to multiplaform ARM architecture. As
>> multiplatform requires usage of the common clock framework, switch from
>> legacy clocks to CCF by replacing the legacy clock framework
>> initialization code in the machine init handler with a common clock
>> framework initialization call in the time init handler.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> ---
>>  arch/arm/mach-shmobile/Kconfig                 |  7 +++++++
>>  arch/arm/mach-shmobile/Makefile                |  1 +
>>  arch/arm/mach-shmobile/board-lager-reference.c | 13 +++++++++----
>>  3 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
>> index 4bb548f..b39f6b6 100644
>> --- a/arch/arm/mach-shmobile/Kconfig
>> +++ b/arch/arm/mach-shmobile/Kconfig
>> @@ -20,6 +20,9 @@ comment "SH-Mobile System Type"
>>  config ARCH_EMEV2
>>       bool "Emma Mobile EV2"
>>
>> +config ARCH_R8A7790
>> +     bool "R-Car H2 (R8A77900)"
>> +
>
> I realise that up until now there has only been one entry,
> but in keeping with the non-SHMOBILE_MULTI entries I think it
> would be good to have the SHMOBILE_MULTI entries sorted in alphabetical
> order. With this in mind could you move ARCH_R8A7790 to
> above ARCH_EMEV2?

Actually, since we have multiple boards that all want to go into
SHMOBILE_MULTI, I wonder if we can merge the initial code early
somehow?

Ideally I'd like to keep the DT reference board build for both CCF and
legacy clocks for a while. So we want the same code to be built with
SHMOBILE and SHMOBILE_MULTI. When we have got the CCF DT bindings
merged then we can get rid of the legacy DT reference build option.

See the following commit for an example:

cbc60e7c04f3c1390144d4a881f0a7b98b49da98

>>  comment "SH-Mobile Board Type"
>>
>>  config MACH_KZM9D
>> @@ -27,6 +30,10 @@ config MACH_KZM9D
>>       depends on ARCH_EMEV2
>>       select REGULATOR_FIXED_VOLTAGE if REGULATOR
>>
>> +config MACH_LAGER
>> +     bool "Lager board"
>> +     depends on ARCH_R8A7790
>> +
>>  comment "SH-Mobile System Configuration"
>>  endif
>>
>> diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
>> index cc48f14..32f3975 100644
>> --- a/arch/arm/mach-shmobile/Makefile
>> +++ b/arch/arm/mach-shmobile/Makefile
>> @@ -57,6 +57,7 @@ obj-$(CONFIG_ARCH_R8A7779)  += pm-r8a7779.o
>>  # Board objects
>>  ifdef CONFIG_ARCH_SHMOBILE_MULTI
>>  obj-$(CONFIG_MACH_KZM9D)     += board-kzm9d-reference.o
>> +obj-$(CONFIG_MACH_LAGER)     += board-lager-reference.o
>>  else
>>  obj-$(CONFIG_MACH_APE6EVM)   += board-ape6evm.o
>>  obj-$(CONFIG_MACH_APE6EVM_REFERENCE) += board-ape6evm-reference.o
>> diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
>> index 1a1a4a8..e436d06 100644
>> --- a/arch/arm/mach-shmobile/board-lager-reference.c
>> +++ b/arch/arm/mach-shmobile/board-lager-reference.c
>> @@ -18,16 +18,21 @@
>>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>>   */
>>
>> +#include <linux/clk/shmobile.h>
>>  #include <linux/init.h>
>>  #include <linux/of_platform.h>
>>  #include <mach/r8a7790.h>
>>  #include <asm/mach/arch.h>
>>
>> -static void __init lager_add_standard_devices(void)
>> +static void __init lager_init_time(void)
>>  {
>> -     /* clocks are setup late during boot in the case of DT */
>> -     r8a7790_clock_init();
>> +     r8a7790_clocks_init(rcar_gen2_read_mode_pins());
>> +
>> +     rcar_gen2_timer_init();
>> +}
>>
>> +static void __init lager_add_standard_devices(void)
>> +{
>>       r8a7790_add_dt_devices();
>>          of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>>  }
>> @@ -40,7 +45,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
>>  DT_MACHINE_START(LAGER_DT, "lager")
>>       .smp            = smp_ops(r8a7790_smp_ops),
>>       .init_early     = r8a7790_init_early,
>> -     .init_time      = rcar_gen2_timer_init,
>> +     .init_time      = lager_init_time,

This looks like it needs some more work. Simon pointed out a typo
related to the MSTP for CMT and that makes me think that this code
wasn't tested with broadcast SMP. So please start by getting the code
working with CMT timer and SMP=n, then gradually enable SMP and
ARCH_TIMER.

Cheers,

/ magnus
