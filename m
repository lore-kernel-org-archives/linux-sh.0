From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 10 Dec 2008 15:29:12 +0000
Subject: Re: [PATCH 01/05] clocksource: add read2() callback and warning
Message-Id: <alpine.LFD.2.00.0812101625240.3325@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20081210151243.32515.61254.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081210151243.32515.61254.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 11 Dec 2008, Magnus Damm wrote:

> From: Magnus Damm <damm@igel.co.jp>
> 
> Add a read2() callback for clocksources and warn if not in place.
> This callback is passing a pointer to struct clocksource which makes
> it easy to share the same callback for multiple clocksource instances.
>
> The function clocksource_read() is modified to prefer read2() over
> read() if initialized, and a warning is emitted at registration
> time if read() is still in use. The jiffy clocksource is updated.

Can we please avoid this read2 hackery ?

# git grep clocksource_register | wc -l
61

It's not really hard to fix them all in one go. I pull the changes
into a branch and make sure that all instances are fixed before I send
the pull request to Linus.

Thanks,

	tglx
