From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 06 Jan 2018 18:13:59 +0000
Subject: Re: [PATCH 1/2] SolutionEngine771x: fix Ether platform data
Message-Id: <85bfc811-4eaf-1140-4452-57542c3c8c3e@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180103201133.743597164@cogentembedded.com>
In-Reply-To: <20180103201133.743597164@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: netdev@vger.kernel.org

Hello!

On 01/03/2018 11:08 PM, Sergei Shtylyov wrote:

> The 'sh_eth' driver's probe() method would fail  on the SolutionEngine7710
> board and crash on SolutionEngine7712 board  as the platform code is
> hopelessly behind the driver's platform data --  it passes the PHY address
> instead of 'struct sh_eth_plat_data *'; pass the latter to the driver in
> order to fix the bug...
> 
> Fixes: 71557a37adb5 ("[netdrvr] sh_eth: Add SH7619 support")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
[...]

    Now that I was finally able to build an SH kernel, I realized that I 
forgot to add #include <linux/sh_eth.h>... :-/

MBR, Sergei

