From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Feb 2015 17:15:22 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <54D8EB2A.1070902@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/09/2015 08:05 PM, Laurent Pinchart wrote:

[...]

>>>>>>> The hardware manual tells me the PHY uses IRQ8#, not IRQ0#.

>>>>>> I don't have the complete Alt schematics.

>>>>> I don't have *any* Alt schematics, only SILK.

>>>> And SILK also has the PHY IRQ connected to IRQ8#.

>>>>>> I've double-checked the block
>>>>>> diagram and it mentions "GP1_24(IRQ)"

>>>>> GP1_24 is connected to the PHY's RST# pin, according to the hardware
>>>>> manual. Which seems bad to me -- we hardly needed such kind of reset
>>>>> with the device tree. :-/ Hopefully, U-Boot leaves it high...

>>>>>> next to the PHY. This patch is thus
>>>>>> incorrect, but where did you find a mention of IRQ8 ?

>>>>> In the Alt hardware manual, rev. 0.04. :-)

>>>> Mentioned in several places there.

>>>> Probably it makes sense to compare the dates of our documents. The
>>>> aforementioned manual is dated June 4, 2014.

>>> The block diagram I have mentions "Rev0.04 Nov 22, 2013", as well as
>>> "PRELIMINARY". Let's use IRQ8 then. IRQ0 is clearly wrong anyway, and we
>>> can always fix this later if the hardware manual is wrong.

>> The Alt schematics I have (rev 0.18 April 24 2014) match what you are
>> saying. RST# on the PHY connected to GP1_24 and INTRP to IRQ8# with pull
>> and pull down resistors as shown in the h/w manual 0.04 Debug Ether block
>> diagram.

> Thank you for the information.

> I've been able to test IRQ8 and the PHY generates a single interrupt, as
> expected. I'll send a v2.

    This patch has been long merged already, so you need to send a fixlet instead.

WBR, Sergei

