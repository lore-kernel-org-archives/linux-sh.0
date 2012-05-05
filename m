From: Anton Vorontsov <anton.vorontsov@linaro.org>
Date: Sat, 05 May 2012 01:47:14 +0000
Subject: Re: [PATCH 1/9] cpu: Introduce clear_tasks_mm_cpumask() helper
Message-Id: <20120505014711.GA24566@lizard>
List-Id: <linux-sh.vger.kernel.org>
References: <20120423070641.GA27702@lizard> <20120423070736.GA30752@lizard>
 <20120426165911.00cebd31.akpm@linux-foundation.org>
In-Reply-To: <20120426165911.00cebd31.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Apr 26, 2012 at 04:59:11PM -0700, Andrew Morton wrote:
[...]
> > 	 so its not like new tasks will ever get this cpu set in
> > +	 * their mm mask. -- Peter Zijlstra
> > +	 * Thus, we may use rcu_read_lock() here, instead of grabbing
> > +	 * full-fledged tasklist_lock.
> > +	 */
> > +	rcu_read_lock();
> > +	for_each_process(p) {
> > +		struct task_struct *t;
> > +
> > +		t = find_lock_task_mm(p);
> > +		if (!t)
> > +			continue;
> > +		cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
> > +		task_unlock(t);
> > +	}
> > +	rcu_read_unlock();
> > +}
> 
> It is good that this code exists under CONFIG_HOTPLUG_CPU.  Did you
> check that everything works correctly with CONFIG_HOTPLUG_CPU=n?

Yeah, only the code under CONFIG_HOTPLUG_CPU calls the function, so
it should be all fine.

Thanks!

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
