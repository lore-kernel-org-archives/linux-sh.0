From: David Miller <davem@davemloft.net>
Date: Mon, 04 Feb 2019 21:31:36 +0000
Subject: Re: [PATCH v2 0/7] sh_eth: implement simple RX checksum offload
Message-Id: <20190204.133136.1764517040498341680.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
In-Reply-To: <a21deed1-35dc-f1be-6c7e-7061ebe4b56c@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 4 Feb 2019 21:01:25 +0300

> Here's a set of 7 patches against DaveM's 'net-next.git' repo. I'm implemeting
> the simple RX checksum offload (like was done for the 'ravb' driver by Simon
> Horman); it has been only tested on the R8A7740 and R8A77980 SoCs, the other
> SoCs should just work (according to their manuals)...

Series applied, thanks.

There was a "tha" --> "the" typo in one of your commit messages which I
fixed up.
