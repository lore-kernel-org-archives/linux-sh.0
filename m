From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Dec 2015 10:30:14 +0000
Subject: Re: [PATCH/RFC 02/03] ARM: shmobile: r8a7795: Hack up SYS-DMAC0 support
Message-Id: <CANqRtoQWtNv8qQou=FTWnQyqMgTo5AfL3-g6GoM+RYBW7ssqoA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215132652.15356.75661.sendpatchset@little-apple>
In-Reply-To: <20151215132652.15356.75661.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 16, 2015 at 5:21 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Dec 15, 2015 at 2:26 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> This hooks up SYS-DMAC0 as r8a7795 device node. Note that the
>> generic compat string is used, this should be replaced by
>> SoC-specific compat string. Not for upstream merge.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> ---
>>
>>  arch/arm64/boot/dts/renesas/r8a7795.dtsi |   30 +++++++++++++++++++++++++++++-
>>  1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> --- 0003/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi       2015-11-10 20:48:56.410513000 +0900
>> @@ -295,7 +295,35 @@
>>                 };
>>
>>                 dmac0: dma-controller@e6700000 {
>> -                       /* Empty node for now */
>> +                       compatible = "renesas,rcar-dmac";
>> +                       reg = <0 0xe6700000 0 0x10000>;
>> +                       interrupts =    <0 119 IRQ_TYPE_LEVEL_HIGH
>
> GIC_SPI
>
> (we should fix up all interrupts properties in R-Car Gen2 DTSes, too)

Thanks, totally agree!

/ magnus
