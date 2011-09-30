From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 30 Sep 2011 09:49:15 +0000
Subject: Re: [PATCH 2/2] usb: r8a66597-udc: add support for SUDMAC
Message-Id: <4E85909B.3000709@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4E803B16.1090905@renesas.com>
In-Reply-To: <4E803B16.1090905@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,
2011/09/30 17:17, Felipe Balbi wrote:
> Hi,
>
< snip >
> On Mon, Sep 26, 2011 at 05:43:02PM +0900, Yoshihiro Shimoda wrote:
>> @@ -186,6 +187,51 @@ static inline void control_reg_sqclr(struct r8a66597 *r8a66597, u16 pipenum)
>>  		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
>>  }
>>
>> +static void control_reg_sqset(struct r8a66597 *r8a66597, u16 pipenum)
>> +{
>> +	unsigned long offset;
>> +
>> +	pipe_stop(r8a66597, pipenum);
>> +
>> +	if (pipenum = 0)
>> +		r8a66597_bset(r8a66597, SQSET, DCPCTR);
>> +	else if (pipenum < R8A66597_MAX_NUM_PIPE) {
>> +		offset = get_pipectr_addr(pipenum);
>> +		r8a66597_bset(r8a66597, SQSET, offset);
>> +	} else
>> +		printk(KERN_ERR "unexpect pipe num(%d)\n", pipenum);
> 
> according to CodingStyle, if one branch as braces, all of them should
> have. Also, try to avoid printk(), I guess you have a *dev here to use
> dev_err(). Besides this, I guess it looks fine.
> 

I knew the rule, but I mistook the code...
I will fix it. And I also use dev_err() instead of printk().

Best regards,
Yoshihiro Shimoda
