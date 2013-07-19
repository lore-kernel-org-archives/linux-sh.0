From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 19 Jul 2013 12:17:06 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Fix ethernet device name in clock definition
Message-Id: <51E92E42.2060104@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 19-07-2013 8:30, Shimoda, Yoshihiro wrote:

> < snip >

>>>>>>> board code callback in sh_eth_plat_data (.set_mdio_gate) isn't used on
>>>>>>> ARM platforms, so the driver should support pure DT bindings without
>>>>>>> auxiliary data.

>>>>>> Maybe it isn't used on ARM but it exists. IMO that's enough reason not to
>>>>>> convert the platform data to the DT properties.

>>>>> I don't agree. The proper fix would be to fix the SuperH platform that
>>>>> uses that callback (there's one only) to replace the callback function
>>>>> with a proper kernel framework.

>>>> At least suggest such framework first.

>>> I would first need to understand what the board code implementes in the
>>> set_mdio_gate() callback. The callback is used by the SH7757LCR board only, do
>>> you have access to the board schematics and SH7757 datasheet ?

>>     No, only for SH7751 manual by coincidence. This SoC doesn't have Ether.
>> Maybe the original commit (sh: add GETHER's platform_device in board-sh7757lcr) author, Shimoda-san, could help us here? I've CC'ed him.

> - The SH7757 has 2 MDIO/MDC channels for Gigabit Ethernet.
> - The board has VSC8244 Gigabit Ethernet PHY.
> - The VSC8244 has 4 MAC channels. But it has one MDIO/MDC port.
> - The board's schematic about MDIO/MDC is like below:
> +--------+ <--- GETHER ch0's MDIO/MDC ---> +-----------+
> | SH7757 | <--- GETHER ch1's MDIO/MDC ---> | bus swith | <--- MDIO/MDC ---> VSC8244
> +--------+ <--- GPIO --------------------> +-----------+

    You apparently forgot to mention 2 Ether devices for which set_mdio_gate() 
method is also used (this is introduced by the same patch). What is the 
GBECONT register you also didn't mention?

> So, I added to control the GPIO using the set_mdio_gate() callback on the board.

> Best regards,
> Yoshihiro Shimoda

WBR, Sergei

