From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Feb 2015 18:18:38 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <54D2627E.1010305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/04/2015 09:12 PM, Geert Uytterhoeven wrote:

>>> I've double-checked the block
>>> diagram and it mentions "GP1_24(IRQ)"

>>     GP1_24 is connected to the PHY's RST# pin, according to the hardware
>> manual. Which seems bad to me -- we hardly needed such kind of reset with

> My (I guess the same as Laurent's) diagram says:
>      GP3_22 (RESET)
>      GP1_24 (IRQ)

    It doesn't make much sense, GP1_24 is not muxed to any IRQ pin... unless 
the GPIO1 controller is used as an interrupt controller, that is.

>> the device tree. :-/ Hopefully, U-Boot leaves it high...

> Can we describe that in DT?

    We can try, probably in the PHY node... but we'd have to add the driver 
support for it.

> Not describing everything will bite us one day (cfr. clocks, PM domains, ...)

    Sigh...

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei

