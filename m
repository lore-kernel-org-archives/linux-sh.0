From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 09 Dec 2015 14:20:59 +0000
Subject: Re: [PATCH net-next] ravb: ptp: fix misplaced ravb_ptp_stop() calling in ravb_probe()
Message-Id: <566838CB.10500@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449599969-20628-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1449599969-20628-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello.

On 12/8/2015 9:39 PM, Yoshihiro Kaneko wrote:

> 'commit <f5d7837f96e5> ("ravb: ptp: Add CONFIG mode support")' added
> a calling of ravb_ptp_stop() in a wrong place in ravb_probe().
>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

    Well, this patch is good to apply anyway:

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei

