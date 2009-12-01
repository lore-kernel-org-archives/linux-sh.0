From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 01 Dec 2009 00:18:55 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: update ecovec24 defconfig
Message-Id: <ubpijsg0g.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uws1cuyrg.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Matt

Thank you for your patch !

> Could you apply this patch and post the backtrace?

Hmm..
I applied your patch, but there are no WARN_ON output...
It still doesn't work.
I tested it on ms7724se / ecovec24
My current git commit is fd2cb0ce74e07babaf8c7bf96ef03c25d194e463
My .config have CONFIG_CACHE_WRITEBACK=y

Best regards
--
Kuninori Morimoto
 
