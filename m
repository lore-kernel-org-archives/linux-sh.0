From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Sat, 24 Mar 2012 12:43:41 +0000
Subject: Re: [PATCH 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
Message-Id: <1332593021.16159.27.camel@twins>
List-Id: <linux-sh.vger.kernel.org>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
In-Reply-To: <20120324102751.GA29067@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, 2012-03-24 at 14:27 +0400, Anton Vorontsov wrote:
> +void clear_tasks_mm_cpumask(int cpu)
> +{
> +       struct task_struct *p;
> +
> +       read_lock(&tasklist_lock);
> +       for_each_process(p) {
> +               struct task_struct *t;
> +
> +               t = find_lock_task_mm(p);
> +               if (!t)
> +                       continue;
> +               cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
> +               task_unlock(t);
> +       }
> +       read_unlock(&tasklist_lock);
> +} 

Why bother with the tasklist_lock at all anymore, afaict you could use
rcu_read_lock() here. This all is called after the cpu is taken down and
marked offline, so its not like new tasks will ever get this cpu set in
their mm mask.


