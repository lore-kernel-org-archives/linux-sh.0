From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 11 Apr 2012 21:54:45 +0000
Subject: Re: [PATCH 2/4] sh: Add sh7264 device
Message-Id: <20120411215442.GA7368@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1334062853-23045-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 11, 2012 at 05:28:43PM +0100, phil.edworthy@renesas.com wrote:
> Ok, I have reworked the patches, but without 16-bit div4 clock regs, the
> board runs really slowly (probably writing to another reg at the same 
> time).

Note that the loops_per_jiffy value is calibrated from the clock
framework so if you have the CPU clock way off this could also lead to
odd behaviour.

> To test my patches, I just hacked the div4 functions to use ioread16/
> iowrite16.
> 
> I used your patch for 8bit module stop, so should I wait for your 16bit
> div4 clock regs patch or send my patches now?
> 
Yes, that's probably the easiest.
