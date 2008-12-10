From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 10 Dec 2008 20:47:40 +0000
Subject: Re: [PATCH 01/05] clocksource: add read2() callback and warning
Message-Id: <alpine.LFD.2.00.0812102144240.3325@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20081210151243.32515.61254.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081210151243.32515.61254.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 10 Dec 2008, john stultz wrote:
> I do somewhat agree with Thomas that maybe just fixing all the in tree
> clocksources instead of creating the dual interface is the way to go.
> But I recognize as an internal interface we may want to deprecate it and
> let out of tree users have some time to convert. So I could go either
> way.

Come on, the function takes now an argument with no further changes to
the function code itself.

It's not a complex change which involves refactoring of code.

Thanks,

	tglx
