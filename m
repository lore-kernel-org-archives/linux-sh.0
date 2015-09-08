From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 08 Sep 2015 20:52:21 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <55EF4A85.8040502@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 09/02/2015 05:13 AM, Simon Horman wrote:

>>> Thanks for the update!
>>
>>> On Fri, Aug 28, 2015 at 10:27 AM, Simon Horman <horms@verge.net.au> wrote:
>>>> --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
>>>> +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
>>>> @@ -6,8 +6,12 @@ interface contains.
>>>>   Required properties:
>>>>   - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
>>>>                "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
>>>> +             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
>>>>   - reg: offset and length of (1) the register block and (2) the stream buffer.
>>>> -- interrupts: interrupt specifier for the sole interrupt.
>>>> +- interrupts: interrupt specifiers.
>>>> +             One data and one emac interrupt for the R8A7795 SoC;
>>
>>     Data?! What the heck does it mean? :-/
>
> Perhaps it would be better to refer to them as dmac interrupts.

    No, they do not seem to be limited to AVB-DMAC.

> The documentation makes reference to "merged data interrupt", which
> seems to refer to tx and rx interrupts. But this interrupt is also
> used for error and management related interrupts.

    Yes.

> I'm all ears with regards to a good name.

    AFAICS from the manual, there are many reasons for these, perhaps calling 
them "a" for ch22 (and "b" for ch23) would make more sense.

> With regards to the documentation consistently referring to "E-MAC",
> which you raised elsewhere. Yes I see that too but I'm not sure where
> you are going there.  If you would like to tweak the documentation
> or name of the interrupt somehow please spell out your ideas a little
> more clearly.

    Please just don't call it emac in the prop description, call it E-MAC, 
that's all.

>>>> +             these interrupts must be named.
>>>> +              One named or unnamed data interrupt otherwise.
>>>>   - phy-mode: see ethernet.txt file in the same directory.
>>>>   - phy-handle: see ethernet.txt file in the same directory.
>>>>   - #address-cells: number of address cells for the MDIO bus, must be equal to 1.
>>>> @@ -18,6 +22,12 @@ Required properties:
>>>>   Optional properties:
>>>>   - interrupt-parent: the phandle for the interrupt controller that services
>>>>                      interrupts for this device.
>>>> +- interrupt-names: Names of named interrupts.
>>>> +                   If the property is present "data" is required.
>>>> +                   "emac" is also required for the R8A7795 SoC;
>>>> +                  it is prohibited otherwise.
>>>> +                  This property is mandatory for the R8A7795 SoC;
>>>> +                  optional otherwise.
>>>>   - pinctrl-names: pin configuration state name ("default").
>>>>   - renesas,no-ether-link: boolean, specify when a board does not provide a proper
>>>>                           AVB_LINK signal.
>>>
>>> What about the 25 channel interrupts?
>>> "data" and "emac" seem to use ch22 resp. ch 24 on Gen3.
>>>
>>> I'm afraid this will bite us one day.
>>
>>     Me too. We should describe the real hardware, not how the driver uses it.
>> Where does configuring the AVB interrupt mode happen?

    Now I'm seeing it happens in the controller itself.

> I believe that we all want that. Lets see about making it so :)
>
> As I mentioned above, broadly speaking the interrupts may be configured in
> one of two modes.

    There are many bits controlling the interrupt routing, so not sure we're 
limited to just 2 modes.

> And the default configuration is to use what I earlier
> described as "compatible". I will now just refer to it as mode 1 with
> the other mode being mode 2.

    I believe I have replied to the text below in a mail to Geert.

[...]

MBR, Sergei

