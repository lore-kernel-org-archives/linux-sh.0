From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Aug 2015 13:00:31 +0000
Subject: Re: [PATCH/RFC 10/10] Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for Salvator-X bo
Message-Id: <55DF09EF.9050102@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 8/27/2015 3:46 PM, Wolfram Sang wrote:

>>>> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>>>>
>>>> This is a work-around for limitations in the driver implementation.
>>>
>>> I know this is marked "local: hack:", still: If this is a driver
>>> limitation, shouldn't it rather be in the dtsi then?
>>
>> You mean, in the driver?
>>
>> DT decribes the hardware, not driver limitations.
>
> I wanted to ensure that this workaround goes into all dts files
> including the r8a7795 dtsi, even custom ones for testing. This is rather
> SoC than board specific, no?

    I don't think so. BTW, the prop is specified for the PHY device which is 
not a part of SoC, so your question is pointless.

MBR, Sergei

