From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 09 Jun 2014 05:49:20 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Add support HSCIF1
Message-Id: <53954AE0.5070408@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1402040741-12436-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1402040741-12436-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Thanks for your review.

(2014/06/06 17:30), Magnus Damm wrote:
> Hi Iwamatsu-san,
>
> Thanks for your patch!
>
> On Fri, Jun 6, 2014 at 4:45 PM, Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.yj@renesas.com>  wrote:
>> Koelsch can use HSCIF1 insetead of SCIF1 as serial port. But if we want to
>> use, we will need to disable the GPIO key and remodeling of the board.
>> Therefore status of hscif1 does not set the "okay".
>
> Do you mean we need to do some soldering on the board? Or is it only a
> matter of changing some DIP switch?

Yes, we need to do some soldering.

>
>> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>>   arch/arm/boot/dts/r8a7791-koelsch.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
>> index b2e6616..cdb53af 100644
>> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
>> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
>> @@ -22,6 +22,7 @@
>>          aliases {
>>                  serial6 =&scif0;
>>                  serial7 =&scif1;
>> +               serial16 =&hscif1;
>>          };
>>
>>          chosen {
>> @@ -258,6 +259,11 @@
>>                  renesas,function = "scif1";
>>          };
>>
>> +       hscif1_pins: serial2 {
>> +               renesas,groups = "hscif1_data", "hscif1_ctrl", "hscif1_clk";
>
> Do you really need the clock portion here? For most UART
> configurations I believe we tend to use internal clocks, so I'm a bit
> surprised to see "hscif1_clk" here.

You are right. We does not need hscif1_clk. I will remove this and re-send patch.

>
>> +               renesas,function = "hscif1";
>> +       };
>> +
>>          ether_pins: ether {
>>                  renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
>>                  renesas,function = "eth";
>> @@ -334,6 +340,11 @@
>>          status = "okay";
>>   };
>>
>> +&hscif1 {
>> +       pinctrl-0 =<&hscif1_pins>;
>> +       pinctrl-names = "default";
>> +};
>> +
>>   &sdhi0 {
>>          pinctrl-0 =<&sdhi0_pins>;
>>          pinctrl-names = "default";
>
> Apart from that it looks good to me!
>
> Cheers,
>
> / magnus

Best regards,
   Nobuhiro
