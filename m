From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Dec 2019 07:48:43 +0000
Subject: Re: [PATCH] SH: Convert ins[bwl]/outs[bwl] macros to inline functions
Message-Id: <878snbgzol.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d0cnh2eb.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d0cnh2eb.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Macro ins[bwl]/outs[bwl] are just calling BUG(), but that results in
> unused variable warnings all over the place.
> This patch convert macro to inline to avoid warning
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

I will post v2 patch soon.
Please drop it


Thank you for your help !!
Best regards
---
Kuninori Morimoto
