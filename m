From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 19 Aug 2009 10:16:26 +0000
Subject: Re: [PATCH] sh: USB0 resource area fix for ms7724se
Message-Id: <upras5csl.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uvdkk64rk.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> > I think this is just your mistake. or is there any reason ?
> 
> You are correct. But please fix other boards and processors using the
> same driver!

I think strange register is SH7724 only.
And the SH7724 board which use USB host is ms7724se only now.

Best regards
--
Kuninori Morimoto
