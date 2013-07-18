From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 18 Jul 2013 11:47:07 +0000
Subject: Re: [PATCH 08/11] ARM: shmobile: r8a7779: cleanup registration of sh_eth
Message-Id: <51E7D5BB.6030305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo69fqds.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo69fqds.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 18-07-2013 3:15, Simon Horman wrote:

>>>> No one is using sh_eth on r8a7779 board.
>>>> remove it

>>     This may yet change (depends on information/support from
>> Renesas), so this is a bit premature. And there's no r8a7779 board,
>> there's Marzen (of the supported now boards).

>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>>>     NAK.

>>     I've added it not to be removed 2 releases later. Quit creating
>> churn please.

> Is there any planned usage for this code, in say the next 3 releases?
> If not I'm inclined to accept this patch. As its not being exercised it
> could easily bit-rot. And it could easily be re-added if it is needed.

     Replied off-list.

WBR, Sergei

