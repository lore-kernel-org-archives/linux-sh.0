From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Thu, 18 Sep 2008 12:25:57 +0000
Subject: Re: [PATCH] mtd: sh_flctl: add support for Renesas SuperH FLCTL
Message-Id: <48D248D5.60106@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48C62D1E.7020906@renesas.com>
	<20080917145731.GA31104@linux-sh.org>
In-Reply-To: <20080917145731.GA31104@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-mtd@lists.infradead.org, dwmw2@infradead.org, linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Tue, Sep 09, 2008 at 05:00:30PM +0900, Yoshihiro Shimoda wrote:
>> Several Renesas SuperH CPU has FLCTL. The FLCTL support NAND Flash.
>> This driver support SH7723.
>>
>> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> 
>> +	flctl->reg = ioremap(res->start, res->end - res->start);
>> +	if (flctl->reg = NULL) {
>> +		printk(KERN_ERR "%s: ioremap error.\n", __func__);
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
> You have an off-by-1 here, this wants to be res->end - res->start + 1.
> 
> Other than that, it looks ok to me at first glance.
> 
> Acked-by: Paul Mundt <lethal@linux-sh.org>
> 

Thank you for your comment. I'll fix up this code.

thanks,
Yoshihiro Shimoda

