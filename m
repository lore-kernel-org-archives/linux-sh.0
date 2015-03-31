From: Richard Cochran <richardcochran@gmail.com>
Date: Tue, 31 Mar 2015 09:01:18 +0000
Subject: Re: [PATCH resend] Renesas Ethernet AVB driver
Message-Id: <20150331090118.GA25765@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <2926619.fiYHPz1IBk@wasted.cogentembedded.com>
 <20150328082853.GA4255@localhost.localdomain>
 <5519D380.6070200@cogentembedded.com>
 <20150331064349.GB4605@localhost.localdomain>
In-Reply-To: <20150331064349.GB4605@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, devicetree@vger.kernel.org, galak@codeaurora.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>, masaru.nagai.vx@renesas.com, David Miller <davem@davemloft.net>

On Tue, Mar 31, 2015 at 08:43:49AM +0200, Richard Cochran wrote:
> I think this is normal policy.  I have seen it more than once on lkml.
> The reason for the author's SOB is to make sure that he or she is
> really authorized (like from the employer) to contribute the driver.

Another issue is maintainership.  If one person submits work written
by someone else, who is responsible for bug fixing?

We already have had one driver (ptp_pch) dumped on us, and nobody
looks after it.

Thanks,
Richard
