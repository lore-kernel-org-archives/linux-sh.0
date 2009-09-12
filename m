From: Rafael Ignacio Zurita <rizurita@yahoo.com>
Date: Sat, 12 Sep 2009 03:58:09 +0000
Subject: Re: Problem with current kernel and old sh3 machines
Message-Id: <20090912035809.GA7489@rafazurita.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
In-Reply-To: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Fri, Sep 11, 2009 at 01:18:41AM -0300, Rafael Ignacio Zurita wrote:
> On Thu, Jul 30, 2009 at 02:25:26PM +0900, Paul Mundt wrote:
> > On Wed, Jul 29, 2009 at 10:11:45PM -0300, Rafael Ignacio Zurita wrote:
> > > Node 0: start_pfn = 0xd000, low = 0xe000                                        
> > > Zone PFN ranges:                                                                
> > >   Normal   0x0000d000 -> 0x0000e000                                             
> > > Movable zone start PFN for each node                                            
> > > early_node_map[1] active PFN ranges                                             
> > >     0: 0x0000d000 -> 0x0000e000                                                 
> > > Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064      
> > > Kernel command line: memM init=/bin/sh earlyprintk=serial                    
> > > NR_IRQS:256                                                                     
> > > PID hash table entries: 64 (order: 6, 256 bytes)                                
> > > Console: colour dummy device 80x25                                              
> > > console handover: boot [sercon0] -> real [tty0]        
> > > 
> > > and I guess that the system hangs. 
> > > Should I try other printks in other places? Suggestions?
> > > 
> > earlyprintk=serial,keep
> 
> Thanks, I get more output for debug.
> Now I got the below kernel messages (sorry for the long output):
> 
...
> 
> The important message (I guess) is :
> 
> 2 locks held by swapper/0:
>  #0:  (clock_list_sem){......}, at: [<8d009928>] clk_register+0x58/0xf0
>  #1:  (clock_list_sem){......}, at: [<8d009c6c>] clk_get_sys+0x1c/0xd0
> Unable to handle kernel NULL pointer dereference at virtual address 0000001c
> 
> 
> So I read for a while arch/sh/kernel/cpu/clock.c
> trying to understand if I see some problem. Both, int clk_register(struct clk *clk)
> and struct clk *clk_get_sys(const char *dev_id, const char *con_id)
> do mutex_lock(&clock_list_sem) and mutex_unlock(&clock_list_sem).
> 
> Then, I did this crazy change below:
> 
> diff -upr linux-2.6.orig/arch/sh/kernel/cpu/clock.c linux-2.6.new/arch/sh/kernel/cpu/clock.c
> --- linux-2.6.orig/arch/sh/kernel/cpu/clock.c	2009-09-11 01:09:35.000000000 -0300
> +++ linux-2.6.new/arch/sh/kernel/cpu/clock.c	2009-09-11 01:12:01.000000000 -0300
> @@ -266,7 +266,7 @@ int clk_register(struct clk *clk)
>  	if (clk->node.next || clk->node.prev)
>  		return 0;
>  
> -	mutex_lock(&clock_list_sem);
> +	/* mutex_lock(&clock_list_sem); */
>  
>  	INIT_LIST_HEAD(&clk->children);
>  	clk->usecount = 0;
> @@ -279,7 +279,7 @@ int clk_register(struct clk *clk)
>  	list_add(&clk->node, &clock_list);
>  	if (clk->ops && clk->ops->init)
>  		clk->ops->init(clk);
> -	mutex_unlock(&clock_list_sem);
> +	/* mutex_unlock(&clock_list_sem); */
>  
>  	return 0;
>  }
> 
> 
> and after building the kernel boots and goes further:

I did printks and I tried to do a tracing :


From arch/sh/kernel/cpu/clock-cpg.c :

static struct clk *onchip_clocks[] = {
	&master_clk,
	&peripheral_clk,
	&bus_clk,
	&cpu_clk,
};

int __init __deprecated cpg_clk_init(void)
{
	int i, ret = 0;

	for (i = 0; i < ARRAY_SIZE(onchip_clocks); i++) {
		struct clk *clk = onchip_clocks[i];
		arch_init_clk_ops(&clk->ops, i);
		if (clk->ops)
			ret |= clk_register(clk);
	}

	return ret;
}


When i=3, clk_register() for cpu_clk looks like a breakage.
clk_register() from arch/sh/kernel/cpu/clock.c says :

int clk_register(struct clk *clk)
{
	if (clk = NULL || IS_ERR(clk))
		return -EINVAL;

	/*
	 * trap out already registered clocks
	 */
	if (clk->node.next || clk->node.prev)
		return 0;

	mutex_lock(&clock_list_sem);

	INIT_LIST_HEAD(&clk->children);
	clk->usecount = 0;

	if (clk->parent)
		list_add(&clk->sibling, &clk->parent->children);
	else
		list_add(&clk->sibling, &root_clks);

	list_add(&clk->node, &clock_list);
	if (clk->ops && clk->ops->init)
		clk->ops->init(clk);
	mutex_unlock(&clock_list_sem);

	return 0;
}
EXPORT_SYMBOL_GPL(clk_register);


There is a first mutex_lock, and then, it calls clk->ops->init(clk). 
From arch/sh/kernel/cpu/sh3/clock-sh7709.c :

static void set_bus_parent(struct clk *clk)
{
	struct clk *bus_clk = clk_get(NULL, "bus_clk");
	clk->parent = bus_clk;
	clk_put(bus_clk);
}

static struct clk_ops sh7709_cpu_clk_ops = {
	.init		= set_bus_parent,
	.recalc		= cpu_clk_recalc,
};

static struct clk_ops *sh7709_clk_ops[] = {
	&sh7709_master_clk_ops,
	&sh7709_module_clk_ops,
	&sh7709_bus_clk_ops,
	&sh7709_cpu_clk_ops,
};


set_bus_parent() calls clk_get(). Then from 
arch/sh/kernel/cpu/clock.c :

struct clk *clk_get(struct device *dev, const char *id)
{
	const char *dev_id = dev ? dev_name(dev) : NULL;
	struct clk *p, *clk = ERR_PTR(-ENOENT);
	int idno;

	clk = clk_get_sys(dev_id, id);

...

struct clk *clk_get_sys(const char *dev_id, const char *con_id)
{
	struct clk *clk;

	mutex_lock(&clock_list_sem);
	clk = clk_find(dev_id, con_id);
	mutex_unlock(&clock_list_sem);

	return clk ? clk : ERR_PTR(-ENOENT);
}
EXPORT_SYMBOL_GPL(clk_get_sys);


Again, a new mutex_lock.
Is that correct? I mean, printks stop with the last 
	for (i = 0; i < ARRAY_SIZE(onchip_clocks); i++) {
in  int __init __deprecated cpg_clk_init(void)

So it looks for me like two locks before the first one unlocks.
If I am reading well, that should not be a proper situation right?
There I would like to see the two below lines 
	if (clk->ops && clk->ops->init)
		clk->ops->init(clk);
out from lock-unlock section. Thoughts?

Rafael
