From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 14 Jul 2014 08:57:16 +0000
Subject: Re: USB doesn't work on ecovec24
Message-Id: <87ion01fo5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAO64nm4gSsfoCTW5m5W=UTQcLYzCFdTE+paD_S3t_wP2Qsn1YA@mail.gmail.com>
In-Reply-To: <CAO64nm4gSsfoCTW5m5W=UTQcLYzCFdTE+paD_S3t_wP2Qsn1YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Daniel

> sh_cmt on the ecovec24 is also currently broken because of a similar
> issue it seems:
> 
> sh_cmt sh-cmt-32.0: cannot get clock
> sh_cmt: probe of sh-cmt-32.0 failed with error -2

Hmm...

latest patch which exchanges cmt is
9b17e48cd4df4e129976c37660cf9ec644c66059
(sh: Switch to new style CMT device)

Anyway, as 1st step, can you please send USB clock fixup patches ?
There is no SH maintainer today.
So, you can use "To:" 

    Andrew Morton <akpm@linux-foundation.org>
