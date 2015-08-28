From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 28 Aug 2015 12:42:45 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <55E05745.5040403@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 08/28/2015 01:51 PM, Sergei Shtylyov wrote:

>>> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
>>> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
>>> @@ -6,8 +6,12 @@ interface contains.
>>>   Required properties:
>>>   - compatible: "renesas,etheravb-r8a7790" if the device is a part of
>>> R8A7790 SoC.
>>>                "renesas,etheravb-r8a7794" if the device is a part of
>>> R8A7794 SoC.
>>> +             "renesas,etheravb-r8a7795" if the device is a part of R8A7795
>>> SoC.
>>>   - reg: offset and length of (1) the register block and (2) the stream
>>> buffer.
>>> -- interrupts: interrupt specifier for the sole interrupt.
>>> +- interrupts: interrupt specifiers.
>>> +             One data and one emac interrupt for the R8A7795 SoC;
>
>     Data?! What the heck does it mean? :-/

    Oh, and the manual consistently spells "emac" as E-MAC.

MBR, Sergei

