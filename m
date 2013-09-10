From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 10 Sep 2013 20:07:13 +0000
Subject: Re: [PATCH v2 2/2] sh_eth: add device tree support
Message-Id: <522F7BF1.80100@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201309070343.25640.sergei.shtylyov@cogentembedded.com> <522E3770.9020305@wwwdotorg.org> <522F2F3A.5070406@cogentembedded.com> <522F37A7.90804@wwwdotorg.org> <522F5E67.8070006@cogentembedded.com>
In-Reply-To: <522F5E67.8070006@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, grant.likely@linaro.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, rob@landley.net, linux-doc@vger.kernel.org

On 09/10/2013 12:01 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 09/10/2013 07:15 PM, Stephen Warren wrote:
> 
>>>> Do you need any clocks properties, IP block reset signals, power
>>>> domains?
> 
>>>     Currently not.
> 
>> What does "currently" mean? Does that mean that the Linux driver simply
>> doesn't touch those entities at present?
> 
>    There's Ether clock but the driver doesn't manipulate it directly,
> assumingly it does this thru the runtime PM interface. As for the
> others, I simply don't know.

If there's a clock, it should be represented in DT, even if the kernel
somehow gets access to the clock through some means other than parsing DT.

>> If so, that's not enough to say
>> that those entities should not be described in the DT binding. We should
>> strive to make the binding completely describe all aspects of the HW,
>> irrespective of whether a particular driver happens to use that
>> information at present.
> 
>    There's no DT representation for the clocks in SH-Mobile subarch yet.
> The same applies to the other entities you mentioned.

You can still write the binding to say that the appropriate clock
property must be present; the overall format of this property won't be
affected by the representation chosen for the SH-Mobile clocks.

It seems like it'd be best to get the basic resources (like clocks)
represented in DT before trying to build blocks that use them.
