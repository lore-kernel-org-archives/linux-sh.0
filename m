From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Fri, 20 Dec 2019 15:42:02 +0000
Subject: Re: [PATCH v2 0/3] sh: fixup strncpy()
Message-Id: <s59o8w3qa0l.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Thu, 19 Dec 2019 10:20:46 +0900,
Kuninori Morimoto wrote:
> 
> 
> Hi Sato-san, Rich
> 
> These are strncpy() fixup patches, but using different solutions.
> Karl's patches are updating current strncpy(), but using 2 patterns.
> Kuninori's patch is using generic strncpy().
> 
> We don't know which is the best, but we can follow
> SH maintainer's selection.
> 
> Karl Nasrallah (2):
>       sh: fixup strncpy() warning and add missing padding
>       sh: fixup strncpy() warning and add missing padding
> 
> Kuninori Morimoto (4):
>       sh: use generic strncpy()
> 
> Thank you for your help !!
> Best regards
> ---
> Kuninori Morimoto

I think the generic version is better, but I want to decide after comparing what code is generated.
If it is not very inefficient, I would like to make it a generic version.

--
Yoshinori Sato
