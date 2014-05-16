From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 16 May 2014 05:56:07 +0000
Subject: Re: Ethernet bug at Upstream-v3.15-rcx on Lager.
Message-Id: <5375A877.1090606@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <53745E88.7040108@jinso.co.jp> <5374F753.70203@cogentembedded.com> <537564FC.4090905@jinso.co.jp>
In-Reply-To: <537564FC.4090905@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: cm-hiep@jinso.co.jp, ben.dooks@codethink.co.uk
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Hi Hiep-san,

(2014/05/16 10:08), カオ　ミン　ヒェップ wrote:
>>
>>> Please review it when you have time.
>>
>>    Please try this patch:
>>
>> http://marc.info/?l=linux-netdev&m9602519809181
>>
> I have tested this patch on v3.15.0-rc5-00077-g14186fe, and results are the message of
> "sh-eth r8a7790-ether eth0: Receive FIFO Overflow" has disappeared and sending datagrams is good.
> (Bandwidth 10M to 100M: Test with 5/5 times by script and by hand are good)
> 

It's nice!
So, I hope the patch is merged in upstream.
However, the patch's change log mentioned r8a7790 only.
The r8a7791's ethernet controller also has this bit.

To Ben,

So, would you update your patch and resubmit it?

Best regards,
Yoshihiro Shimoda
