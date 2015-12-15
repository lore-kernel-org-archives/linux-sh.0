From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 15 Dec 2015 11:33:48 +0000
Subject: Re: [PATCH v3 2/3] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <566FFA9C.6010900@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449799947-19866-1-git-send-email-horms+renesas@verge.net.au>
 <1449799947-19866-3-git-send-email-horms+renesas@verge.net.au>
 <566AC07B.6060201@cogentembedded.com> <20151215064134.GA29842@verge.net.au>
In-Reply-To: <20151215064134.GA29842@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 12/15/2015 9:41 AM, Simon Horman wrote:

>>> Add fallback compatibility strings for R-Car Gen2 and Gen3.
>>> This is in keeping with the fallback scheme being adopted wherever
>>> appropriate for drivers for Renesas SoCs.
>>>
>>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>>> ---
>>> v3
>>> * Moved documentation of SoC names to a separate patch
>>> * Use correct fallback compatibility string in example
>>>
>>> v2
>>> * Add R-Car Gen2 and Gen3 fallback compatibility strings rather than
>>>    a single compatibility string for all of R-Car.
>>> ---
>>>   Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 10 +++++++++-
>>>   drivers/usb/renesas_usbhs/common.c                      |  9 +++++++++
>>>   2 files changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
>>> index a14c0bb561d5..c55cf77006d0 100644
>>> --- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
>>> +++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
>>> @@ -2,10 +2,18 @@ Renesas Electronics USBHS driver
>>>
>>>   Required properties:
>>>     - compatible: Must contain one of the following:
>>
>>     Really?
>
> Would "...one or more of the following" help?

    It would, of course.

>>> +
>>>   	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
>>>   	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
>>>   	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
>>>   	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
>>> +	- "renesas,rcar-gen2-usbhs" for R-Car Gen2 compatible device
>>> +	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 compatible device
>>> +
>>> +	When compatible with the generic version, nodes must list the
>>> +	SoC-specific version corresponding to the platform first followed
>>> +	by the generic version.
>>> +
>>
>>     This kinda contradicts the above claim.
>>
>> [...]

MBR, Sergei

