From: David Miller <davem@davemloft.net>
Date: Wed, 21 Aug 2013 00:05:36 +0000
Subject: Re: [PATCH 1/2] sh_eth: get register layout from 'struct sh_eth_cpu_data'
Message-Id: <20130820.170536.1573745208374127042.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201308180308.39941.sergei.shtylyov@cogentembedded.com>
	<201308180311.28814.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308180311.28814.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 18 Aug 2013 03:11:28 +0400

> The register layout is a SoC characteristic, so it's wrong that it's stored
> in the otherwise board specific platform data. Add 'register_type' field to
> 'struct sh_eth_cpu_data', initialize it properly for each SoC, and read  it
> from this structure instead of the platfrom data from now on...  
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
