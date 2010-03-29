From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Mar 2010 03:16:17 +0000
Subject: Re: [PATCH 6/7] arch/sh/kernel: Use set_cpus_allowed_ptr
Message-Id: <20100329031617.GB26500@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1003262303300.6480@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003262303300.6480@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <julia@diku.dk>
Cc: peterz@infradead.org, mingo@elte.hu, tglx@linutronix.de, oleg@redhat.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

On Fri, Mar 26, 2010 at 11:03:49PM +0100, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Use set_cpus_allowed_ptr rather than set_cpus_allowed.
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression E1,E2;
> @@
> 
> - set_cpus_allowed(E1, cpumask_of_cpu(E2))
> + set_cpus_allowed_ptr(E1, cpumask_of(E2))
> 
> @@
> expression E;
> identifier I;
> @@
> 
> - set_cpus_allowed(E, I)
> + set_cpus_allowed_ptr(E, &I)
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>
> 
Applied, thanks.
