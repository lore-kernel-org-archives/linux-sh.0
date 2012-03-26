From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Mon, 26 Mar 2012 07:59:06 +0000
Subject: Re: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
Message-Id: <1332748746.16159.62.camel@twins>
List-Id: <linux-sh.vger.kernel.org>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
 <20120325174210.GA23605@redhat.com>
In-Reply-To: <20120325174210.GA23605@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, 2012-03-25 at 19:42 +0200, Oleg Nesterov wrote:
> __cpu_disable() is called by __stop_machine(), we know that nobody
> can preempt us and other CPUs can do nothing. 

It would be very good to not rely on that though, I would love to get
rid of the stop_machine usage in cpu hotplug some day.
