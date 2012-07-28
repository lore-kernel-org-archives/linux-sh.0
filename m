From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 28 Jul 2012 00:48:10 +0000
Subject: Re: [Regression, post-3.5] System suspend broken on the Mackerel board
Message-Id: <20120728004809.GH30468@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201207280053.11701.rjw@sisk.pl>
In-Reply-To: <201207280053.11701.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sat, Jul 28, 2012 at 12:53:11AM +0200, Rafael J. Wysocki wrote:
> Hi Paul,
> 
> Unfortunately, your commit
> 
> commit ca5481c68e9fbcea62bb3c78ae6cccf99ca8fb73
> Author: Paul Mundt <lethal@linux-sh.org>
> Date:   Tue Jul 10 12:08:14 2012 +0900
> 
>     sh: pfc: Rudimentary pinctrl-backed GPIO support.
> 
> breaks system suspend on the Mackerel board (.config attached).  The system
> simply doesn't suspend and instead it hangs somewhere while suspending
> devices (apparently before running the "late" callbacks).
> 
> If the above commit is reverted, system suspend works normally.
> 
Ok, I'll take a look at it on Monday, thanks for reporting.
