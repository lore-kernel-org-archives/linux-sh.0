From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 22 Jul 2013 09:15:05 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Fix ethernet device name in clock definition
Message-Id: <51ECF819.1020400@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

(2013/07/19 21:17), Sergei Shtylyov wrote:
> Hello.
> 
> On 19-07-2013 8:30, Shimoda, Yoshihiro wrote:
> 
>> < snip >
> 
>>>>>>>> board code callback in sh_eth_plat_data (.set_mdio_gate) isn't used on
>>>>>>>> ARM platforms, so the driver should support pure DT bindings without
>>>>>>>> auxiliary data.
> 
>>>>>>> Maybe it isn't used on ARM but it exists. IMO that's enough reason not to
>>>>>>> convert the platform data to the DT properties.
> 
>>>>>> I don't agree. The proper fix would be to fix the SuperH platform that
>>>>>> uses that callback (there's one only) to replace the callback function
>>>>>> with a proper kernel framework.
> 
>>>>> At least suggest such framework first.
> 
>>>> I would first need to understand what the board code implementes in the
>>>> set_mdio_gate() callback. The callback is used by the SH7757LCR board only, do
>>>> you have access to the board schematics and SH7757 datasheet ?
> 
>>>     No, only for SH7751 manual by coincidence. This SoC doesn't have Ether.
>>> Maybe the original commit (sh: add GETHER's platform_device in board-sh7757lcr) author, Shimoda-san, could help us here? I've CC'ed him.
> 
>> - The SH7757 has 2 MDIO/MDC channels for Gigabit Ethernet.
>> - The board has VSC8244 Gigabit Ethernet PHY.
>> - The VSC8244 has 4 MAC channels. But it has one MDIO/MDC port.
>> - The board's schematic about MDIO/MDC is like below:
>> +--------+ <--- GETHER ch0's MDIO/MDC ---> +-----------+
>> | SH7757 | <--- GETHER ch1's MDIO/MDC ---> | bus swith | <--- MDIO/MDC ---> VSC8244
>> +--------+ <--- GPIO --------------------> +-----------+
> 
>    You apparently forgot to mention 2 Ether devices for which set_mdio_gate() method is also used (this is introduced by the same patch). What is the GBECONT register you also didn't mention?

Sorry, I forgot to mention the GBECONT register.
So, I would like to rewrite my description about .set_mdio_gate() of board-sh7757lcr.c:

- The SH7757 has 2 Gigabit Ethernet controllers (GETHER) and
  2 Fast Ethernet controllers (ETHER).
- The SH7757 has 2 MDIO/MDC channels, but those are multiplexed port.
- The SH7757 has the GBECONT register:
 - If "RMII0" is set to 1, the ETHER channel 0 can use the MDIO/MDC channel 0.
 - If "RMII0" is set to 0, the GETHER channel 0 can use the MDIO/MDC channel 0.
 - If "RMII1" is set to 1, the ETHER channel 1 can use the MDIO/MDC channel 1.
 - If "RMII1" is set to 0, the GETHER channel 1 can use the MDIO/MDC channel 1.
- The board has 2 DP83848C Fast Ethernet PHYs.
- The board has VSC8244 Gigabit Ethernet PHY.
- The VSC8244 has 4 MAC channels. But it has one MDIO/MDC port.
- The board's schematic about MDIO/MDC is like below:
+--------+                     +--> DP83848C
|        | <-- MDIO/MDC ch 0 --+--> +------------+
| SH7757 | <-- GPIO --------------> | bus switch | <-- MDIO/MDC --> VSC8244
|        | <-- MDIO/MDC ch 1 --+--> +------------+
+--------+                     +--> DP83848C
- About the bus switch:
 - If the GPIO is set to high, the bus switch will conenct the MDIO/MDC ch 0 to VSC8244.
 - If the GPIO is set to low, the bus switch will conenct the MDIO/MDC ch 1 to VSC8244.

So, if the ETHER channel 0 wants to use the MDIO/MDC ch 0,
the "RMII0" should be set to 1.
So, if the GETHER channel 0 wants to use the MDIO/MDC ch 0,
the "RMII0" should be set to 0 and the GPIO should be set to High.

Best regards,
Yoshihiro Shimoda

>> So, I added to control the GPIO using the set_mdio_gate() callback on the board.
> 
>> Best regards,
>> Yoshihiro Shimoda
> 
> WBR, Sergei
> 
> 
