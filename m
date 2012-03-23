From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 23 Mar 2012 08:39:56 +0000
Subject: Re: [PATCH] sh: fixup section mismatch worning for intc_set_ack_handle()
Message-Id: <871uojsobr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120323070518.GG26543@linux-sh.org>
In-Reply-To: <20120323070518.GG26543@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> > WARNING: drivers/built-in.o(.text+0x5d760):
> > Section mismatch in reference from the function
> > intc_set_ack_handle() to the function .init.text:intc_ack_data()
> > The function intc_set_ack_handle()
> > references the function __init intc_ack_data().
> > This is often because intc_set_ack_handle lacks a __init
> > annotation or the annotation of intc_ack_data is wrong.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Hmm, no. This is just papering over the problem. The real issue is that
> intc_ack_data() is flagged __init when it shouldn't be. I'll fix it up,
> thanks for reporting it.

OK. thank you.
please add

Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
