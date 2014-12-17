From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 17 Dec 2014 08:38:54 +0000
Subject: Re: [PATCH v2 1/7] ARM: shmobile: ape6evm: synchronize dts with reference platform
Message-Id: <CAO3366wZ2WDgc02KR1JY1nuwzduHAJ5bt=xQcUOj06pPJwEE4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418747163-21729-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418747163-21729-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 16, 2014 at 11:38 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 16 December 2014 17:25:57 Ulrich Hecht wrote:
[...]
>>       lbsc {
>> +             compatible = "simple-bus";
>>               #address-cells = <1>;
>>               #size-cells = <1>;
>> +             ranges = <0 0 0 0x20000000>;
>>
>>               ethernet@8000000 {
>> -                     compatible = "smsc,lan9118", "smsc,lan9115";
>> +                     compatible = "smsc,lan9220", "smsc,lan9115";
>>                       reg = <0x08000000 0x1000>;
>>                       interrupt-parent = <&irqc1>;
>>                       interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
>
> Which branch is this based on ? Simon's latest devel branch doesn't have a
> /lbsc/ethernet node in arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts. The
> bootargs value is also different.

That's because the file isn't r8a73a4-ape6evm-reference.dts, it's
r8a73a4-ape6evm.dts.

The idea here is to add all the bells and whistles to
r8a73a4-ape6evm.dts instead of the reference file to avoid having to
move it later.

CU
Uli
