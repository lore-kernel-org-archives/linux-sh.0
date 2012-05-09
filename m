From: phil.edworthy@renesas.com
Date: Wed, 09 May 2012 06:05:23 +0000
Subject: Re: [PATCH 2/4] sh: Add sh7264 device
Message-Id: <OF9750143C.500702C3-ON802579F9.00215863-802579F9.0021742F@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

> > I found some time to look at the issue with 16-bit clock source 
registers
> > on sh2a. This is on top of your changes to extend sh_clk_mstp for 8 & 
16
> > bti regs. Is this the sort of thing you were thinking of?
> > 
> There's already support for this merged in
> 104fa61a7dd83197160d5cafedc0e94ad9cd7fcc ("sh: clkfwk: Support
> variable size accesses for div4/div6 clocks.").
Ah, I missed that... at least my patch is nearly identical :)

Thanks
Phil
