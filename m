From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 30 May 2014 14:04:34 +0000
Subject: Re: Ethernet bug at Upstream-v3.15-rcx on Lager.
Message-Id: <53888FF2.8040505@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <53745E88.7040108@jinso.co.jp> <5374F753.70203@cogentembedded.com> <537564FC.4090905@jinso.co.jp> <5375A877.1090606@renesas.com>
In-Reply-To: <5375A877.1090606@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, cm-hiep@jinso.co.jp
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On 16/05/14 06:56, Yoshihiro Shimoda wrote:
> Hi Hiep-san,
> 
> (2014/05/16 10:08), カオ　ミン　ヒェップ wrote:
>>>
>>>> Please review it when you have time.
>>>
>>>    Please try this patch:
>>>
>>> http://marc.info/?l=linux-netdev&m9602519809181
>>>
>> I have tested this patch on v3.15.0-rc5-00077-g14186fe, and results are the message of
>> "sh-eth r8a7790-ether eth0: Receive FIFO Overflow" has disappeared and sending datagrams is good.
>> (Bandwidth 10M to 100M: Test with 5/5 times by script and by hand are good)
>>
> 
> It's nice!
> So, I hope the patch is merged in upstream.
> However, the patch's change log mentioned r8a7790 only.
> The r8a7791's ethernet controller also has this bit.

The bit update covers both of them as the r8a7790 and r8a7791 both share
the same configuration structure.

I re-sent the patch but didn't find your email post until after I had
sent it, otherwise I would have mentioned your testing specifically. In
future it would be helpful if you could do the following

- Mention driver by name in the subject line
- Search the list for previous mentions and reply to that/those threads.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
