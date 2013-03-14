From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Mar 2013 07:01:47 +0000
Subject: Re: [PATCH 04/04] ARM: shmobile: APE6EVM support
Message-Id: <CANqRtoR-bC0SjEkXH_+GNU_4T0CT0rRbeq_Tt2AhB1mk_S_cjA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045637.19701.62477.sendpatchset@w520>
 <201303121216.21953.arnd@arndb.de>
In-Reply-To: <201303121216.21953.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Tue, Mar 12, 2013 at 9:16 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Magnus Damm wrote:
>> +
>> +static const char *ape6evm_boards_compat_dt[] __initdata = {
>> +       "renesas,ape6evm",
>> +       NULL,
>> +};
>> +
>> +DT_MACHINE_START(APE6EVM_DT, "ape6evm")
>> +       .init_irq       = irqchip_init,
>> +       .init_time      = shmobile_timer_init,
>> +       .init_machine   = r8a73a4_add_standard_devices,
>> +       .dt_compat      = ape6evm_boards_compat_dt,
>> +MACHINE_END
>
> Do you plan to add board-specific contents here in a follow-up patch soon?

Yes, correct. At this point we cannot configure the pin controller from DT.

> If not, it seems the setup-r8a73a4.c already handles this board with its
> defaults.

Right, this portion is only made as a ground work for incremental patches.

Thanks,

/ magnus
