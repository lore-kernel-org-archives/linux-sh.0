From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 16 Apr 2009 02:56:58 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <uprfduwzp.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Iwamatsu

> In current code, when sci_handle_errors was called ,
> sci_rxd_in seemed to come to be called it.
> Did you check this?

OK. Now I could understand.
I think sci_rxd_in function is not called in SH7723.
This function is for SCI which can not get
rx break status from register.

Best regards
--
Kuninori Morimoto
 
