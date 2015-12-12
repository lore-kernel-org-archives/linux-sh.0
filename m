From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 12 Dec 2015 22:24:13 +0000
Subject: Re: [PATCH] sh_eth: move inline functions to the header file
Message-Id: <566C9E8D.7060704@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4254119.qJUdUQCUqs@wasted.cogentembedded.com>
 <20150407.152249.360575010614186977.davem@davemloft.net>
 <55242F5F.2060409@cogentembedded.com>
 <20150407.153337.1789757717574323514.davem@davemloft.net>
In-Reply-To: <20150407.153337.1789757717574323514.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 04/07/2015 10:33 PM, David Miller wrote:

>>>> The explicitly inline functions belong to the header files, so move
>>>> cpu_to_edmac() and edmac_to_cpu() into the driver header.
>>
>>>> While at it, make these functions return 'u32' instead of '__u32'.
>>
>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>> Then... ummm... remove the inline keyword?
>>
>>> If it's not used anywhere else, that's the thing to do.
>>
>>     Results in more code, as I noted in the patch posting that you skipped
>>     when replying. At least with gcc 4.7.
>
> That's a compiler bug.

    Just tried x86 gcc 5.1.1, same result:

$ size drivers/net/ethernet/renesas/sh_eth.o{~,}
    text	   data	    bss	    dec	    hex	filename
   23245	   1188	      0	  24433	   5f71	drivers/net/ethernet/renesas/sh_eth.o~
   23259	   1188	      0	  24447	   5f7f	drivers/net/ethernet/renesas/sh_eth.o

i.e. +14 bytes of code. :-O

MBR, Sergei

