From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Apr 2009 22:10:11 +0000
Subject: Re: [PATCH v2] sh7786: modify usb setup timeout judgment bug.
Message-Id: <20090413221011.GE14847@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uskkdh0oz.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uskkdh0oz.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 10, 2009 at 09:54:07AM +0900, Kuninori Morimoto wrote:
> Timeout counter "i" can reach -1 if USB setup isn't done.
> And "i" can be 0 if USB setup is done when last possible moment.
> Then it is judged to fail though setup is done.
> This patch modify this problem.
> Special thanks to Mr. Juha Leppanen and Iwamatsu-san for nice advice.
> 
> Reported-by: "Juha Leppanen" <juha_motorsportcom@luukku.com>
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> >> Paul
> Can you test this patch on Urquell board please ?
> 
Ok, back in the office now. Yes, this works fine. I'll add a Reviewed-by
for Iwamatsu-san.

> >> Michael
> I will try to create patch which skip setup if bootloader is already done.
> please wait.
> 
Since this current patches addresses a bug, I'll check this in as it is.
If you want to post an incremental patch implementing Michael's
suggestion on top of this, we can roll that in to a later update.

You might want to make sure you aren't stepping on anything Shimoda-san
is doing though with his fix aimed at the host controller drivers.
