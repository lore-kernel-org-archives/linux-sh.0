From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 09 Apr 2009 05:53:10 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <49DD8D46.6030408@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk55vvebh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

morimoto.kuninori@renesas.com wrote:
> Dear Iwamatsu
> 
>>> I think that this is coding miss.
>>> If you check implemenation of other SH CPU's(e.g. SH7722),
>>> you can understand that other CPU checked RXD bit.
>> If this is a just "coding miss", I can understand !!
>> Thank you
> 
> Oops.
> But Can we really read RXD status from IO port ?
> Because when we use SCIF/SCIFA,
> function modules is selected in PFC.
> it is not IO port.
> 
We set function to use in PFC and it is from IO-port
and controls them.

For example, we want to get RXD of SCIF0, setup PSELC and PTCR,
and get value from PTDR.

OK?

Best regards,
  Nobuhiro

