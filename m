From: David Miller <davem@davemloft.net>
Date: Thu, 05 Nov 2015 16:13:48 +0000
Subject: Re: [PATCH] sh_eth: merge sh_eth_free_dma_buffer() into sh_eth_ring_free()
Message-Id: <20151105.111348.1315362570048541764.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <6672379.kyQ5eFYq8y@wasted.cogentembedded.com>
	<20151104.205939.1680085474215420643.davem@davemloft.net>
	<563B5144.8050800@cogentembedded.com>
In-Reply-To: <563B5144.8050800@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 5 Nov 2015 15:53:24 +0300

> Hello.
> 
> On 11/5/2015 4:59 AM, David Miller wrote:
> 
>>> While the ring allocation is done by a single function,
>>> sh_eth_ring_init(),
>>> the ring deallocation was split into two functions (almost always
>>> called
>>> one after the other) for no good reason. Merge
>>> sh_eth_free_dma_buffer()
>>> into sh_eth_ring_free() which allows us  to save space not only on the
>>> direct calls of the former function but also on the
>>> sh_eth_ring_init()'s
>>> simplified error path...
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> Applied.
> 
>    Hum, I'm seeing both patches in the net.git repo, while they were
>    clearly targeted to net-next.git... Did you really consider these 2
>    patches fixes?

It was more work for me to let the patches rot in patchwork until I openned
net-next back up than to simply just apply them to net.

You guys really make an enormous amount of work and stress for me when you
submit net-next patches when I _CLEARLY_ and _EXPLICITLY_ state that the
tree is closed right now.
