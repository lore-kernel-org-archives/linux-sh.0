From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 15 Dec 2015 18:06:16 +0000
Subject: Re: [PATCH] sh_eth: fix descriptor access endianness
Message-Id: <56705698.9010703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <11070795.yxBPvlHg4n@wasted.cogentembedded.com>
 <20151215.002541.762812772082527155.davem@davemloft.net>
 <566FF8FB.2010005@cogentembedded.com>
 <20151215.125336.1876941788722356501.davem@davemloft.net>
In-Reply-To: <20151215.125336.1876941788722356501.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

On 12/15/2015 08:53 PM, David Miller wrote:

>>>> The driver never calls cpu_to_edmac() when writing the descriptor
>>>> address
>>>> and edmac_to_cpu() when reading it, although it should -- fix this.
>>>>
>>>> Note that the frame/buffer length descriptor field accesses also need
>>>> fixing
>>>> but since they are both 16-bit we can't use
>>>> {cpu|edmac}_to_{edmac|cpu}()...
>>>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>> Applied.
>>
>>     I was going to rework this to fix _all_ cases, and sent follow-up
>>     email about that yesterday... Haven't you received it?
>
> I saw it but you were not entirely clear whether you were going to do
> that work in a follow-on patch or not.
>
> If you don't clearly say "Dave, please drop this patch." expect me to
> do random things.

    Previously I had a plan to get rid of never used EDMAC_BIG_ENDIAN and then 
get rid of {edmac|cpu}_to_{cpu|edmac}() and fix 16-bit descriptor R/W by using 
{cpu|le32}_to_{le32|cpu}(). How's that plan to you?

MBR, Sergei

