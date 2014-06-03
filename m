From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 03 Jun 2014 02:43:26 +0000
Subject: Re: Ethernet bug at Upstream-v3.15-rcx on Lager.
Message-Id: <538D364E.6040605@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53745E88.7040108@jinso.co.jp> <5374F753.70203@cogentembedded.com> <537564FC.4090905@jinso.co.jp> <5375A877.1090606@renesas.com> <53888FF2.8040505@codethink.co.uk>
In-Reply-To: <53888FF2.8040505@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, cm-hiep@jinso.co.jp
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Hi Ben,

(2014/05/30 23:04), Ben Dooks wrote:
> On 16/05/14 06:56, Yoshihiro Shimoda wrote:
>> Hi Hiep-san,
>>
>> (2014/05/16 10:08), カオ　ミン　ヒェップ wrote:
>>>>
>>>>> Please review it when you have time.
>>>>
>>>>    Please try this patch:
>>>>
>>>> http://marc.info/?l=linux-netdev&m9602519809181
>>>>
>>> I have tested this patch on v3.15.0-rc5-00077-g14186fe, and results are the message of
>>> "sh-eth r8a7790-ether eth0: Receive FIFO Overflow" has disappeared and sending datagrams is good.
>>> (Bandwidth 10M to 100M: Test with 5/5 times by script and by hand are good)
>>>
>>
>> It's nice!
>> So, I hope the patch is merged in upstream.
>> However, the patch's change log mentioned r8a7790 only.
>> The r8a7791's ethernet controller also has this bit.
> 
> The bit update covers both of them as the r8a7790 and r8a7791 both share
> the same configuration structure.
> 
> I re-sent the patch but didn't find your email post until after I had
> sent it, otherwise I would have mentioned your testing specifically. In
> future it would be helpful if you could do the following
> 
> - Mention driver by name in the subject line
> - Search the list for previous mentions and reply to that/those threads.
> 

Thank you very much for the comment and your v2 patch!
I understood it.

Best regards,
Yoshihiro Shimoda
