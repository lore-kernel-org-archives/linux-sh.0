From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Sep 2013 16:12:29 +0000
Subject: Re: [PATCH] sh_eth: NAPI requires netif_receive_skb()
Message-Id: <Pine.LNX.4.64.1309261751200.11968@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201309030303.11381.sergei.shtylyov@cogentembedded.com>
 <20130904.141252.532474080722830977.davem@davemloft.net>
In-Reply-To: <20130904.141252.532474080722830977.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sergei.shtylyov@cogentembedded.com, netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hi

On Wed, 4 Sep 2013, David Miller wrote:

> From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Date: Tue, 3 Sep 2013 03:03:10 +0400
> 
> > Driver supporting NAPI should use NAPI-specific function for receiving packets,
> > so netif_rx() should be changed to netif_receive_skb().
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

This patch breaks NFS boot on Armadillo800eva for me. Network 
communication slows down to a crawl with

net eth0: Receive FIFO Overflow
nfs: server 192.168.x.y not responding, still trying

With this patch reverted (e.g. in today's Linus tree snapshot) boot is 
restored.

Thanks
Guennadi

> Applied.

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
