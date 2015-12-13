From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 13 Dec 2015 21:10:31 +0000
Subject: Re: [PATCH net-next] ravb: ptp: fix misplaced ravb_ptp_stop() calling in ravb_probe()
Message-Id: <566DDEC7.9050302@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449599969-20628-1-git-send-email-ykaneko0929@gmail.com>
 <566838CB.10500@cogentembedded.com>
 <CAH1o70KogcskpKP+yx3A52c3spAakroRiAuRfi4HkkQq0NguHA@mail.gmail.com>
In-Reply-To: <CAH1o70KogcskpKP+yx3A52c3spAakroRiAuRfi4HkkQq0NguHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello.

On 12/13/2015 06:39 PM, Yoshihiro Kaneko wrote:

>>> 'commit <f5d7837f96e5> ("ravb: ptp: Add CONFIG mode support")' added
>>> a calling of ravb_ptp_stop() in a wrong place in ravb_probe().
>>>
>>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>>
>>
>>     Well, this patch is good to apply anyway:
>
> I thought that the interrupt should be disabled before freeing memory.
> anyway, thanks.

    You mean PTP interrupts?

MBR, Sergei

