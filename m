From: Chai Wen <chaiw.fnst@cn.fujitsu.com>
Date: Wed, 15 Oct 2014 12:13:32 +0000
Subject: [Issue] access cpu_cycles PMU conter in r8a7791
Message-Id: <543E64EC.7090009@cn.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi developers,

Sorry for some disturbing.

I am planing to use pmu counter cpu_cycles to measure the elapsed time of some small pieces of code.
But I found that I can not make the PMU work properly.

My cpu is called r8a7791, a 2-core cpu. And the kernel version is 3.10.31.
The following is my simple code to test it and its result.

I found that no matter what's the scale of this loop:
	for (i = 0; i < loops; i++) {
		__asm__ __volatile__("mov r0, r0\n\t");
	}
	the cycles counts got via:
	__asm__ __volatile__("MRC p15, 0, %0, c9, c13, 0\n\t" : "=r"(count));
	are not significantly different from each other. I am confused about these values.

Any comment or help is appreciated, thanks a lot.

============
num of counters: 6
before count: 0
loops is 100 takes cycles 104665
num of counters: 6
before count: 0
loops is 500 takes cycles 104650
num of counters: 6
before count: 0
loops is 1000 takes cycles 104827
num of counters: 6
before count: 0
loops is 5000 takes cycles 120351
num of counters: 6
before count: 0
loops is 10000 takes cycles 105041
num of counters: 6
before count: 0
loops is 50000 takes cycles 115470
num of counters: 6
before count: 0
loops is 100000 takes cycles 107905
num of counters: 6
before count: 0
loops is 500000 takes cycles 120427
num of counters: 6
before count: 9
loops is 1000000 takes cycles 145033



-------------------------------------------------
#include <linux/init.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/preempt.h>

MODULE_LICENSE("GPL");


static unsigned int loops0;
module_param(loops, uint, S_IRUGO);

static unsigned int get_pmucycles(void)
{
	unsigned int count;
	__asm__ __volatile__("MRC p15, 0, %0, c9, c13, 0\n\t" : "=r"(count));
	return count;
}

static int __init pmu_init(void)
{
	unsigned int value = 0x1;
	unsigned int num_counters;
	unsigned int i;
	unsigned int count1, count2;

	//__asm__ __volatile__("MCR p15, 0, %0, c9, c14, 0\n\t" :: "r"(1));
	/* disable interrupt request */
	__asm__ __volatile__("MCR p15, 0, %0, c9, c14, 2\n\t" :: "r"(0x8000001f));


	__asm__ __volatile__("MRC p15, 0, %0, c9, c12, 0\n\t" : "=r"(num_counters));
	num_counters = (num_counters >> 11) & 0x1FU;
	printk("num of counters: %u\n", num_counters);

	value |= 0x6; //reset and enable counters
	value |= 0x8;   //enable cycles counter divide

	__asm__ __volatile__("MCR p15, 0, %0, c9, c12, 0\n\t" :: "r"(value));
	/* enable all possible counters */
	__asm__ __volatile__("MCR p15, 0, %0, c9, c12, 1\n\t" :: "r"(0x8000001f));
	/* clear counters */
	__asm__ __volatile__("MCR p15, 0, %0, c9, c12, 3\n\t" :: "r"(0x8000001f));
	/* select cycles counter */
	__asm__ __volatile__("MCR p15, 0, %0, c9, c12, 5\n\t" :: "r"(0x1f));
	
	count1 = get_pmucycles();
	printk("before count: %u\n", count1);
	
	preempt_disable();
	for (i = 0; i < loops; i++) {
		__asm__ __volatile__("mov r0, r0\n\t");
	}
	preempt_enable();
	
	count2 = get_pmucycles();
	if (count2 < count1)
	printk("after count: %u\n", count2);
	printk("loops is %u takes cycles %u\n", loops, count2 - count1);
	return -1;
}

static void __exit pmu_exit(void)
{
	printk("bye\n");
}

module_init(pmu_init);
module_exit(pmu_exit);
--------------------------------------

-- 
Regards

Chai Wen
