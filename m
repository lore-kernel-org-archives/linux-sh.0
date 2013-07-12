From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 12 Jul 2013 11:20:52 +0000
Subject: Re: [PATCH 08/11] ARM: shmobile: r8a7779: cleanup registration of sh_eth
Message-Id: <51DFE694.7080303@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo69fqds.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo69fqds.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 11-07-2013 15:39, Sergei Shtylyov wrote:

>> No one is using sh_eth on r8a7779 board.
>> remove it

    This may yet change (depends on information/support from Renesas), 
so this is a bit premature. And there's no r8a7779 board, there's Marzen 
(of the supported now boards).

>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>     NAK.

    I've added it not to be removed 2 releases later. Quit creating 
churn please.

WBR, Sergei

