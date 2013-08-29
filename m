From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 29 Aug 2013 20:29:06 +0000
Subject: Re: [PATCH] sh_eth: no need to call ether_setup()
Message-Id: <521FAF12.5070508@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308300024.48415.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308300024.48415.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

Hello.

On 08/30/2013 12:24 AM, Sergei Shtylyov wrote:

> There's no need to call ether_setup() in the driver since prior alloc_etherdev()
> call already arranges for it.

> Suggested-by: Denis Kirjanov <kda@linux-powerpc.org>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---

   Sorry, forgot to mention the patch is against the 'net-next.git' repo. :-/

WBR, Sergei

