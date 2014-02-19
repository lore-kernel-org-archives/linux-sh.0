From: David Miller <davem@davemloft.net>
Date: Wed, 19 Feb 2014 17:54:32 +0000
Subject: Re: [PATCH v2] of_mdio: fix phy interrupt passing
Message-Id: <20140219.125432.903199758409719335.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20140218161551.44A52C40517@trevor.secretlab.ca>
	<20140218.181317.1712776234149210938.davem@davemloft.net>
	<5304B14B.2070402@cogentembedded.com>
In-Reply-To: <5304B14B.2070402@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: grant.likely@linaro.org, ben.dooks@codethink.co.uk, linux-kernel@lists.codethink.co.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 19 Feb 2014 17:27:39 +0400

>    So, you decided to ignore my comment about unneeded *else* branch?

Not ignored, just figured that a follow-up patch could fix it.
