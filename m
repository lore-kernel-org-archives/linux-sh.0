From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 16 Oct 2013 22:41:59 +0000
Subject: Re: [PATCH v2 2/2] sh_eth: add device tree support
Message-Id: <525F1637.3040709@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070343.25640.sergei.shtylyov@cogentembedded.com> <522E3770.9020305@wwwdotorg.org> <522F2F3A.5070406@cogentembedded.com> <522F37A7.90804@wwwdotorg.org> <522F5E67.8070006@cogentembedded.com> <522F7BF1.80100@wwwdotorg.org> <522F93A5.6010709@cogentembedded.com> <522F9B65.1020606@wwwdotorg.org>
In-Reply-To: <522F9B65.1020606@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, rob@landley.net, linux-doc@vger.kernel.org, Simon Horman <horms@verge.net.au>

Hello.

On 09/11/2013 02:21 AM, Stephen Warren wrote:

>>>>>>> Do you need any clocks properties, IP block reset signals, power
>>>>>>> domains?

>>>>>>       Currently not.

>>>>> What does "currently" mean? Does that mean that the Linux driver simply
>>>>> doesn't touch those entities at present?

>>>>      There's Ether clock but the driver doesn't manipulate it directly,
>>>> assumingly it does this thru the runtime PM interface. As for the
>>>> others, I simply don't know.

>>> If there's a clock, it should be represented in DT, even if the kernel
>>> somehow gets access to the clock through some means other than parsing
>>> DT.

>>     Frankly speaking, I don't see the point.

> To be honest, that doesn't exactly make me care about reviewing the
> binding then.

    Well, that would seem to make my task easier unless you mean that you'd 
just NAK my further attempts of pushing this patch. :-)
    It seems somewhat unfair to require clock DT support for the Ethernet 
driver (which doesn't even use clocks directly), while R-Car I2C driver DT 
support has been queued successfully at the same time (this driver uses clock 
API directly).

>>>>> If so, that's not enough to say
>>>>> that those entities should not be described in the DT binding. We
>>>>> should
>>>>> strive to make the binding completely describe all aspects of the HW,
>>>>> irrespective of whether a particular driver happens to use that
>>>>> information at present.

>>>> There's no DT representation for the clocks in SH-Mobile subarch yet.
>>>> The same applies to the other entities you mentioned.

>>> You can still write the binding to say that the appropriate clock
>>> property must be present; the overall format of this property won't be
>>> affected by the representation chosen for the SH-Mobile clocks.

>>     Where can I find an example of such property, independent of the
>> parent clock node? All I could find with quick search refers with a
>> phandle to a clock node (we don't have now).

> All clock property definitions are independent of the source of the clock.

> Now the actual value you put in the DT file is dependent on which source
> it's describing.

    AFAIU, we'd need the "root" clock node still to which the clock properties 
would refer via phandle.

>>> It seems like it'd be best to get the basic resources (like clocks)
>>> represented in DT before trying to build blocks that use them.

>>     We don't use them directly. And we need the Ether device tree support *now*,
>> while clock-related work will probably take months (there are plans to switch Sh-Mobile to CCF in like 6 months).

> What/who is "we".

    Our customer Renesas, and therefore we, Cogent Embedded. Note that clock 
DT support is not the part of our tasks.

> If it's just a matter of the driver-vs-runtime-pm
> code, then it's not relevant.

> I don't think needing something now is a good excuse.

    Hm, perhaps we still can do things in the planned order? Magnus, could you 
clarify again what are the plans on clock DT support for the R8A777x/R8A779x SoCs?
    I'm still hoping we can deal with the Ethernet DT support first and then 
we'd add the clock property to the binding when it would become availble.

WBR, Sergei

