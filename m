From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 31 Mar 2015 17:40:34 +0000
Subject: Re: [PATCH resend] Renesas Ethernet AVB driver
Message-Id: <551ADC12.5050603@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150328082853.GA4255@localhost.localdomain>	<5519D380.6070200@cogentembedded.com>	<20150331064349.GB4605@localhost.localdomain> <20150331.113832.2042398685489897677.davem@davemloft.net>
In-Reply-To: <20150331.113832.2042398685489897677.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, richardcochran@gmail.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org, mitsuhiro.kimura.kc@renesas.com, masaru.nagai.vx@renesas.com

Hello.

On 03/31/2015 06:38 PM, David Miller wrote:

>>>> We also need SOB from Mitsuhiro and Masaru.

>>>     Hmm, it's the first time I encounter such requirement.

>> I think this is normal policy.  I have seen it more than once on lkml.
>> The reason for the author's SOB is to make sure that he or she is
>> really authorized (like from the employer) to contribute the driver.

    We (Cogent Embedded) are authorized to do this, isn't this enough?

>> [adding davem on CC]

>> Dave, is that correct?

> I refuse to apply any patch without an appropriate signoff.

    But what do you mean by "appropriate signoff"? I have provided mine but 
Richard insists there should be sign-offs from the primary driver authors -- 
it's the first time I'm encountering such a requirement.

WBR, Sergei

