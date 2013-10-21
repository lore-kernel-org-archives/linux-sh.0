From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 21 Oct 2013 04:46:22 +0000
Subject: Re: [PATCH 1/2 v3] ARM: shmobile: r8a7790: add QSPI support
Message-Id: <87r4bfb59h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382326020-10558-2-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> 
> Adds support for QSPI on the r8a7790.
> 
> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
> ---
(snip)
>  enum {
> -	MSTP931, MSTP930, MSTP929, MSTP928,
> +	MSTP931, MSTP930, MSTP929, MSTP928, MSTP917,

This is not a big deal,
but the original MSTP numbering seems already broken.
I can fix these if you want.



Best regards
---
Kuninori Morimoto
