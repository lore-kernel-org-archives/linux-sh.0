From: David Miller <davem@davemloft.net>
Date: Mon, 15 Jan 2018 20:10:09 +0000
Subject: Re: [PATCH 0/2] sh_eth: simplify TSU initialization
Message-Id: <20180115.151009.1771710412167174925.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20180114174742.388057652@cogentembedded.com>
In-Reply-To: <20180114174742.388057652@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Jan 2018 20:47:42 +0300

> Here's a set of 2 patches against DaveM's 'net-next.git' repo. With those,
> I'm somewhat simplifying the TSU init code in the driver probe() method...
> 
> [1/2] sh_eth: gather all TSU init code in one place
> [2/2] sh_eth: get Ether port # only when needed

Series applied, thanks Sergei.
