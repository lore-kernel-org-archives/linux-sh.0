From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Nov 2013 05:32:03 +0000
Subject: Re: [PATCH] irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
Message-Id: <CANqRtoQ1ip--Yorp=VYRzT7No36oQN26buYF2MqSRGdLkSNQXQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Nov 12, 2013 at 10:22 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Tuesday 12 November 2013 14:44:13 Magnus Damm wrote:
>> On Sat, Nov 9, 2013 at 9:18 PM, Laurent Pinchart wrote:
>> > The SENSE register bitfield position is incorrectly computed for SoCs
>> > that use 2-bit IRQ sense fields. Fix it.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>>
>> I checked this against the sh73a0 data sheet which is using 4-bit IRQ
>> sense and it looks correct to me.
>>
>> It would nice nice if someone could test this on r8a7778 or r8a7779
>> which I believe use 2-bit IRQ sense.
>
> I've tested it on Lager. This is what prompted me to write the patch.

Lager is using R-Car H2 which in turn uses IRQC, not INTC.

So I guess this is a typo. You probably mean a R-Car Gen 1 board or SH-Mobile.

>> Also, in the future, since the INTC hardware is kind of diverse,
>> please consider including SoC information in the commit message.
>
> OK I will.

Thanks,

/ magnus
