From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2009 07:36:34 +0000
Subject: Re: [PATCH] net: sh_eth alignment fix for sh7724 using NET_IP_ALIGN
Message-Id: <aec7e5c30912142336m22558444v1e61328cf2c2ee0b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30912142313p111565d4mc0014c581cd431d4@mail.gmail.com>
	 <20091214.231534.225225771.davem@davemloft.net>
	 <aec7e5c30912142322w21fb4a1bved19f7344f1cf1a5@mail.gmail.com>
	 <20091214.233433.191391098.davem@davemloft.net>
In-Reply-To: <20091214.233433.191391098.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Tue, Dec 15, 2009 at 4:34 PM, David Miller <davem@davemloft.net> wrote:
> From: Magnus Damm <magnus.damm@gmail.com>
> Date: Tue, 15 Dec 2009 16:22:11 +0900
>
>> On Tue, Dec 15, 2009 at 4:15 PM, David Miller <davem@davemloft.net> wrote:
>>> NET_IP_ALIGN is never != 2 on SUPERH
>>>
>>> SH_ETH depends on SUPERH
>>>
>>> It's a fantasy ifdef, of sorts. :-)
>>
>> Sure, but _maybe_ someone will put the sh_eth hardware block together
>> with MIPS or ARM in the future.
>
> MIPS and ARM use the default NET_IP_ALIGN of 2 as well.
>
> Next?

I'll just get rid of the #ifdef and make a V2. Thanks! =)

/ magnus
