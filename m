From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 13 Aug 2013 21:32:21 +0000
Subject: Re: [PATCH] SolutionEngine SH771x: remove Ether support
Message-Id: <520AA5E5.5000803@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308130217.03133.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308130217.03133.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, lethal@linux-sh.org
Cc: netdev@vger.kernel.org, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Hello.

On 08/13/2013 02:17 AM, I wrote:

> The 'sh_eth' driver's probe will crash as the platform code is hopelessly behind
> the platform data -- it passes PHY ID instead of 'struct sh_eth_plat_data *'.
> Even if it's fixed, the driver probe will fail as the 'struct sh_eth_cpu_data'
> indicates presence of TSU but the platform device resource  for it is absent.
> Since I have no data to fix it, I think it's best to remove the erratic code.

    After looking at the original driver, it seems I've got the necessary 
data... but both Ether controllers seems to have shared TSU which is not yet 
supported by the driver (there was a patch from Iwamatsu-san to implement it 
but it hasn't been merged).

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

WBR, Sergei

