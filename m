From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 08 Jul 2013 08:00:00 +0000
Subject: Re: [PATCH v2 3/4] ARM: shmobile: ape6evm-reference: add CPUFreq support
Message-Id: <Pine.LNX.4.64.1307080958270.19819@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 8 Jul 2013, Guennadi Liakhovetski wrote:

[snip]

> Or have I misunderstood? As for your other idea:
> 
> <quote>
> Also, in parallel with platform device in C board
> code you should add DT nodes for the DT reference board support.
> </quote>
> 
> Do you mean adding that "cpufreq-cpu0" device from DT? That's (currently) 
> impossible. The cpufreq-cpu0.c driver doesn't have an .of_match_table 
> field. Since otherwise this is a DT-specific driver - it parses CPU0 DT 
> data - I don't think that was an oversight of the author, instead it must 
> have been their conscious decision. Exact reasons are unknown to me.

Ok, I think, I know why. Probably, because that "device" doesn't describe 
"real hardware," instead, it's just a driver activation helper.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
