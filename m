From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 10 Aug 2019 05:14:02 +0000
Subject: Re: [PATCH] sh: kernel: disassemble: Mark expected switch fall-throughs
Message-Id: <9f8dd34d-373c-eaf9-00ec-436745a1a025@embeddedor.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190810050153.GA13927@embeddedor>
 <996bc110024500842a627ea75cb43b7cd00ef36c.camel@perches.com>
In-Reply-To: <996bc110024500842a627ea75cb43b7cd00ef36c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>



On 8/10/19 12:08 AM, Joe Perches wrote:
> On Sat, 2019-08-10 at 00:01 -0500, Gustavo A. R. Silva wrote:
>> Mark switch cases where we are expecting to fall through.
>>
>> Fix the following warnings (Building: defconfig sh):
> []
>> diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
> []
>> @@ -477,6 +477,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>>  			case FD_REG_N:
>>  				if (0)
>>  					goto d_reg_n;
> 
> Might as well remove this if (0) goto,
> remove the added comment
> 

You're right. I'll respin and stop working this Friday midnight.

>> +				/* else, fall through */
>>  			case F_REG_N:
>>  				printk("fr%d", rn);
>>  				break;
>> @@ -488,6 +489,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>>  					printk("xd%d", rn & ~1);
>>  					break;
>>  				}
>> +				/* else, fall through */
>>  			d_reg_n:
> 
> and remove this only use of d_reg_n
> 

Sure.

Thanks
--
Gustavo

>>  			case D_REG_N:
>>  				printk("dr%d", rn);
>> @@ -497,6 +499,7 @@ static void print_sh_insn(u32 memaddr, u16 insn)
>>  					printk("xd%d", rm & ~1);
>>  					break;
>>  				}
>> +				/* else, fall through */
>>  			case D_REG_M:
>>  				printk("dr%d", rm);
>>  				break;
> 
