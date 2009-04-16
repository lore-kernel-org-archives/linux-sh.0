From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 16 Apr 2009 02:46:08 +0000
Subject: Re: [PATCH 3/6] Add USB support for SH7724
Message-Id: <uskk9uxhr.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear all

> >> Hm... In the future we want to control the above dynamically for
> >> better power savings. I guess it's ok as-is for now.
> > 
> > Looking a bit in r8a66597.h, I wonder if USBPOWERON is similar to
> > VBOUT that is present in DVSTCR on external devices?
> 
> I also think UPONCR register control port power. I think this register
> differ from SH7786.
> I will modify the r8a66597 driver and be able to control those registers
> with r8a66597's ops. It's like a sh_mobile_lcdcfb's display_on function. :)

Thank you shimoda-san.
When your modification was applied,
I will send patch to use it for SH7786/SH7724.

In my opinion, SH7724 needs .power_on function,
and SH7786 needs .init function to r8a66597's ops.

Best regards
--
Kuninori Morimoto
 
