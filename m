From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 14 Apr 2015 16:58:18 +0000
Subject: Re: [PATCH resend] Renesas Ethernet AVB driver
Message-Id: <552D472A.6080309@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2926619.fiYHPz1IBk@wasted.cogentembedded.com> <20150328082853.GA4255@localhost.localdomain> <5519D380.6070200@cogentembedded.com> <552C25BE.3070606@cogentembedded.com> <20150414052729.GA5179@netboy> <552CE890.3040103@cogentembedded.com> <20150414163002.GB4309@localhost.localdomain>
In-Reply-To: <20150414163002.GB4309@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Cochran <richardcochran@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>, masaru.nagai.vx@renesas.com

Hello.

On 04/14/2015 07:30 PM, Richard Cochran wrote:

>>> It is surely avoidable.  The driver knows (or should know) whether or
>>> not the hardware has been configured or not.

>>     So you only want to avoid the register read here?

> No, that is not what I mean.  The two callers are gettime and adjtime.
> Can't you make sure the hardware is ready before you register the

    I tried to explain to you that I can't. We enter the device configuration 
mode (from the operation mode) when e.g. the *Ethernet* device is closed.

> clock in the first place?  If not, what is purpose of returning EBUSY?

    I'm not sure (remember, I'm not the primary author), perhaps this is to 
prevent bad time values when the AVB-DMAC in not operational... Nagai-san, 
could you explain this please?

> Thanks,
> Richard

WBR, Sergei

