From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 15 Apr 2009 02:52:39 +0000
Subject: Re: Question about sh-sci on SH7723
Message-Id: <49E54BF7.4040408@renesas.com>
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
>> We set function to use in PFC and it is from IO-port
>> and controls them.
>>
>> For example, we want to get RXD of SCIF0, setup PSELC and PTCR,
>> and get value from PTDR.
> 
> Hmm....
> Now I tried to watch PxDR behavior by JTAG.
> Then, I can read data from PxDR if PxCR is "I/O".
> But, I can not read data when PxCR is "Function".
> It is always 0x00.
> I think at least clock bit will change.
> 
> Do you know why ?
> 

In current code, when sci_handle_errors was called ,
sci_rxd_in seemed to come to be called it.
Did you check this?

Thanks,
  Nobuhiro
