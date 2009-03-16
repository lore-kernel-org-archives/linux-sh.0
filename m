From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 16 Mar 2009 05:24:18 +0000
Subject: Re: [PATCH] sh: clkfwk: Changed the init function
Message-Id: <49BDE282.3040601@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BA1505.7000500@st.com>
In-Reply-To: <49BA1505.7000500@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Jean-Christophe
>> (clk->flags & CLK_ALWAYS_ENABLED)
>> @@ -167,6 +156,11 @@ EXPORT_SYMBOL_GPL(clk_disable);
>>  
>>  int clk_register(struct clk *clk)
>>  {
>> +
>> +	if (clk->ops && clk->ops->init)
>> +		if (clk->ops->init(clk))
>> +			return -EINVAL;
>> +
>>     
> why do you check the return if all clk_init will always return 0; ?
>
> IMHO if clk-ops is NULL return directly instead of recheck it later
>
> Best Regards,
> J.
>   
I'm sorry but I don't understand your issue.
You are right if you mean the current SOC-clocks implementations return 
0 in all the .init functions...

But it was currently required to maintain a working system (it's the 
only manner to change a void function with the int function).

In the future if required the .init function will be able to do extra 
check and if required it will be able to
 reject a clock registration.

Currently it could seem useless (all .init return zero) but for my point 
of view it's only a currently issue... And not really an issue.

Regards
 Francesco
