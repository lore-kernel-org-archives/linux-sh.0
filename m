From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 29 Sep 2009 09:26:45 +0000
Subject: Re: currect MigoR seems doesn't work
Message-Id: <uiqf2qey2.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljjyqojh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for comment

> Last time i checked objdump was broken with dsp instructions.
> Disabling dsp support in the kernel should solve the issue short term.

OK. if I remove DSP from .config,
I can use objdump !!

But MigoR still doesn't work now.
I need debug for it...

Thank you again

Best regards
--
Kuninori Morimoto
