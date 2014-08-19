From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Aug 2014 00:37:45 +0000
Subject: Re: [PATCH 4/8] ARM: shmobile: Initial r8a7794 and Alt device tree
Message-Id: <CANqRtoTFbfyrxpNs7SJSNQuVL7yQe5cHpSuxPyNTUKa3oKD9Nw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <0d0771ab2bd5f57a62db91f26bba1e9f522d16cb.1380530437.git.horms+renesas@verge.net.au>
In-Reply-To: <0d0771ab2bd5f57a62db91f26bba1e9f522d16cb.1380530437.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 19, 2014 at 8:39 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Aug 18, 2014 at 05:51:43PM +0200, Ulrich Hecht wrote:
>> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>> [uli: reduced to minimum, added cmt, enabled scif2]
>> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>> ---
>>  arch/arm/boot/dts/Makefile                |   3 +-
>>  arch/arm/boot/dts/r8a7794-alt.dts         |  47 +++
>>  arch/arm/boot/dts/r8a7794.dtsi            | 531 ++++++++++++++++++++++++++++++
>>  include/dt-bindings/clock/r8a7794-clock.h |  82 +++++
>>  4 files changed, 662 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/r8a7794-alt.dts
>>  create mode 100644 arch/arm/boot/dts/r8a7794.dtsi
>>  create mode 100644 include/dt-bindings/clock/r8a7794-clock.h
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b8c5cd3..81c1df9 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -375,7 +375,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
>>       r8a7791-henninger.dtb \
>>       r8a7791-koelsch.dtb \
>>       r8a7790-lager.dtb \
>> -     r8a7779-marzen.dtb
>> +     r8a7779-marzen.dtb \
>> +     r8a7794-alt.dtb
>>  dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
>>       socfpga_cyclone5_socdk.dtb \
>>       socfpga_cyclone5_sockit.dtb \
>> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
>> new file mode 100644
>> index 0000000..a05d3b1
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
>> @@ -0,0 +1,47 @@
>> +/*
>> + * Device Tree Source for the Alt board
>> + *
>> + * Copyright (C) 2014 Renesas Electronics Corporation
>> + *
>> + * This file is licensed under the terms of the GNU General Public License
>> + * version 2.  This program is licensed "as is" without any warranty of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +/dts-v1/;
>> +#include "r8a7794.dtsi"
>> +
>> +/ {
>> +     model = "Alt";
>> +     compatible = "renesas,alt", "renesas,r8a7794";
>> +
>> +     aliases {
>> +             serial10 = &scif2;
>> +     };
>
> Ulrich, Magnus, Larurent,
>
> I'm wondering if this alias is necessary as there is no precedence
> in mainline for the console being on serial port 10.

My take on this is that we should follow latest common upstream
convention, which I believe is using serial0 for the debug port.

Cheers,

/ magnsu
