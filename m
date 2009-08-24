From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 24 Aug 2009 09:45:45 +0000
Subject: Re: Current ms7724se LAN doesn't work
Message-Id: <uy6p9r1di.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Thank you for your patch

> This would be a runtime PM issue, which SH-Mobile unconditionally
> selects. The problem is that the module is most likely disabled via its
> MSTP bit under the new scheme, so sh-eth will need to tie in to the
> runtime PM framework to get that resolved.
> 
> Can you give this a try?

hmmm..
I tried this patch, but it still doesn't work.
log is 

----------
(snip)
usbcore: registered new interface driver usbhid                                 
usbhid: v2.6:USB HID core driver                                                
heartbeat: version 0.1.1 loaded                                                 
TCP cubic registered                                                            
NET: Registered protocol family 17                                              
RPC: Registered udp transport module.                                           
RPC: Registered tcp transport module.                                           
/opt/usr/src/WORK/morimoto/gitlinux/sh-2.6/drivers/rtc/hctosys.c: unable to ope)
IP-Config: Failed to open eth0                                                  
eth1: link down                                                                 
Sending DHCP requests ......
----------

Best regards
--
Kuninori Morimoto
 
