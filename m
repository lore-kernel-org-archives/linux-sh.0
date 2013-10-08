From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 08 Oct 2013 20:53:37 +0000
Subject: Re: [PATCH] sh_eth: NAPI requires netif_receive_skb()
Message-Id: <52547E8D.3080101@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201309030303.11381.sergei.shtylyov@cogentembedded.com> <20130904.141252.532474080722830977.davem@davemloft.net> <Pine.LNX.4.64.1309261751200.11968@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1309261751200.11968@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hello.

On 26-09-2013 18:12, Guennadi Liakhovetski wrote:

>> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> Date: Tue, 3 Sep 2013 03:03:10 +0400

>>> Driver supporting NAPI should use NAPI-specific function for receiving packets,
>>> so netif_rx() should be changed to netif_receive_skb().

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> This patch breaks NFS boot on Armadillo800eva for me. Network
> communication slows down to a crawl with

> net eth0: Receive FIFO Overflow
> nfs: server 192.168.x.y not responding, still trying

> With this patch reverted (e.g. in today's Linus tree snapshot) boot is
> restored.

    Guennadi, are you expecting some actions (like looking into what Eric have 
suggested) from me? If so, I'm still on vacation, should be back next Tuesday.
    I don't think reverting the patch is a Right Thing to do.

> Thanks
> Guennadi

WBR, Sergei

