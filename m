From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Wed, 13 May 2009 07:32:14 +0000
Subject: Re: [PATCH] sh: clkfw: Moved the .init callback in the clk_regsiter
Message-Id: <4A0A777E.3090006@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
In-Reply-To: <1242050283-7986-1-git-send-email-francesco.virlinzi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Jean-Christophe
Thank for your feedback.
Suggestion applied in the [v3] version.
Regards
 Francesco
Jean-Christophe PLAGNIOL-VILLARD ha scritto:
>> -		__clk_init(clk);
>> -
>>  		__clk_enable(clk->parent);
>>  
>>  		if (clk->ops && clk->ops->enable)
>> @@ -175,16 +155,19 @@ EXPORT_SYMBOL_GPL(clk_disable);
>>  
>>  int clk_register(struct clk *clk)
>>  {
>> +
>> +	if (clk->ops && clk->ops->init)
>> +		if (clk->ops->init(clk) < 0)
>> +			return -EPERM;
>>     
> why not allow the clock to return a specifc errno?
>   
>> +
>>  	mutex_lock(&clock_list_sem);
>>  
>>  	list_add(&clk->node, &clock_list);
>>  	clk->usecount = 0;
>> -	clk->flags |= CLK_NEEDS_INIT;
>>  
>>  	mutex_unlock(&clock_list_sem);
>>  
>>  	if (clk->flags & CLK_ALWAYS_ENABLED) {
>> -		__clk_init(clk);
>>  		pr_debug( "Clock '%s' is ALWAYS_ENABLED\n", clk->name);
>>  		if (clk->ops && clk->ops->enable)
>>  			clk->ops->enable(clk);
>> diff --git a/arch/sh/kernel/cpu/sh2/clock-sh7619.c b/arch/sh/kernel/cpu/sh2/clock-sh7619.c
>> index d2c1579..5549534 100644
>> --- a/arch/sh/kernel/cpu/sh2/clock-sh7619.c
>> +++ b/arch/sh/kernel/cpu/sh2/clock-sh7619.c
>> @@ -29,9 +29,10 @@ static const int pfc_divisors[] = {1,2,0,4};
>>  #error "Illigal Clock Mode!"
>>  #endif
>>  
>> -static void master_clk_init(struct clk *clk)
>> +static int master_clk_init(struct clk *clk)
>>  {
>>  	clk->rate *= PLL2 * pll1rate[(ctrl_inw(FREQCR) >> 8) & 7];
>> +	return 0;
>>  }
>>  
>>  static struct clk_ops sh7619_master_clk_ops = {
>>     
> <snip>
>   
>> diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
>> index a334294..2c46a51 100644
>> --- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
>> +++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
>> @@ -66,7 +66,7 @@ static struct clk sh4202_femi_clk = {
>>  	.ops		= &sh4202_femi_clk_ops,
>>  };
>>  
>> -static void shoc_clk_init(struct clk *clk)
>> +static int shoc_clk_init(struct clk *clk)
>>  {
>>  	int i;
>>  
>> @@ -88,6 +88,7 @@ static void shoc_clk_init(struct clk *clk)
>>  	}
>>  
>>  	WARN_ON(i = ARRAY_SIZE(frqcr3_divisors));	/* Undefined clock */
>> +	return 0;
>>     
> return 0? if the clock in undefined it will best to report it, is not?
>   
>>  }
>>  
>>  static void shoc_clk_recalc(struct clk *clk)
>> diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4.c b/arch/sh/kernel/cpu/sh4/clock-sh4.c
>> index dca9f87..70794ac 100644
>> --- a/arch/sh/kernel/cpu/sh4/clock-sh4.c
>> +++ b/arch/sh/kernel/cpu/sh4/clock-sh4.c
>> @@ -26,9 +26,10 @@ static int ifc_divisors[] = { 1, 2, 3, 4, 6, 8, 1, 1 };
>>  #define bfc_divisors ifc_divisors	/* Same */
>>  static int pfc_divisors[] = { 2, 3, 4, 6, 8, 2, 2, 2 };
>>  
>>     
> Best Regards,
> J.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

