From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 15 May 2013 14:05:50 +0000
Subject: Re: [PATCH v6 9/9] rcar-phy: handle platform data
Message-Id: <5193963E.1020904@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304231942.08507.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 15-05-2013 18:01, Felipe Balbi wrote:

>>> BTW, conversion away from iowrite32() could (should) be part of a
>>> separate patch. No need to prevent this one from being applied.

>>     Of course. You mean conversion to plain writel(), right?

> right, "away" from iowrite32() ;-)

    Well, I used to think it's implemented everywhere now, as the recent 
trend seems to use it in preference to readl(), at least in several 
subsystems...

    BTW, how about ACKing patch #7 now that I've recast it?

WBR, Sergei

