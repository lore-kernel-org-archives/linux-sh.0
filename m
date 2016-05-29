From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Sun, 29 May 2016 23:37:28 +0000
Subject: Re: [PATCH v3 00/16] genrtc removal
Message-Id: <20160529233728.GP3451@piout.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1461796470-1291527-1-git-send-email-arnd@arndb.de>
 <20160503072418.GA2335@piout.net>
 <3351574.jQ0612lD2O@wuerfel>
In-Reply-To: <3351574.jQ0612lD2O@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, deller-Mmb7MZpHnFY@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org, dalias-8zAoT0mYgF4@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org

Hi,

On 03/05/2016 at 12:05:34 +0200, Arnd Bergmann wrote :
> On Tuesday 03 May 2016 09:24:18 Alexandre Belloni wrote:
> > Hi Arnd,
> > 
> > I see you didn't copy Greg on that series (that may explain his
> > confusion on the previous patch), do you expect me to take it
> > through the RTC tree? That is fine but I'd like some acks from him.
> 
> Yes, that was a mistake. I dropped Greg from one Cc list in v2 when
> I split up the RTC changes into the part that was for drivers/rtc
> and the other one for Greg's char-misc tree. Then I reused the first
> Cc list when I sent a combined series for v3 again. I'll fix that
> when I post v4. There are only very small changes in there that
> I still need to pick up, so hopefully that will be the last version.
> 
> It would be nice if you could take it through your tree then.
> 

We are now at 4.7-rc1. Can you send v4 soon so that I can apply that
series  and get it in linux-next?

There is a small rebase to do on patch v3.

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
