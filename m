From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 14 Apr 2015 10:14:40 +0000
Subject: Re: [PATCH resend] Renesas Ethernet AVB driver
Message-Id: <552CE890.3040103@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2926619.fiYHPz1IBk@wasted.cogentembedded.com> <20150328082853.GA4255@localhost.localdomain> <5519D380.6070200@cogentembedded.com> <552C25BE.3070606@cogentembedded.com> <20150414052729.GA5179@netboy>
In-Reply-To: <20150414052729.GA5179@netboy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Cochran <richardcochran@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>, masaru.nagai.vx@renesas.com

Hello.

On 4/14/2015 8:27 AM, Richard Cochran wrote:

>>>> This is a bit hacky.  Can't your driver make sure that the HW is ready?

>>>     Will look into this. Perhaps it's a remainder from when the PTP driver was
>>> separate...

>>     No, we enter this mode upon closing the Ethernet device and when
>> the ring DMA sizes are changed. Seems unavoidable...

>>>>> +    if (ravb_read(priv->ndev, CSR) & CSR_OPS_CONFIG)
>>>>> +        return true;
>>>>> +    else
>>>>> +        return false;

> It is surely avoidable.  The driver knows (or should know) whether or
> not the hardware has been configured or not.

    So you only want to avoid the register read here?

> Thanks,
> Richard

WBR, Sergei

