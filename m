From: David Miller <davem@davemloft.net>
Date: Tue, 03 Nov 2015 03:32:52 +0000
Subject: Re: [PATCH v2 0/2] sh_eth: fix bugs in sh_eth_ring_init()
Message-Id: <20151102.223252.1187774093228458041.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <3291270.dPgp9opalf@wasted.cogentembedded.com>
	<20151102.155639.1614788692883883662.davem@davemloft.net>
	<5637E44D.1070006@cogentembedded.com>
In-Reply-To: <5637E44D.1070006@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 3 Nov 2015 01:31:41 +0300

> On 11/02/2015 11:56 PM, David Miller wrote:
> 
>>>     Here's a set of 2 patches against DaveM's 'net.git' repo which fix
>>>     couple of
>>> bugs in the sh_eth_ring_init() function.
>>
>> Series applied.
> 
>    As these fixed the error path, I don't expect you to push them to
>    -stable, but your call.

It's actually more your call, not mine.
