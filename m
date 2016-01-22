From: Dirk Behme <dirk.behme@de.bosch.com>
Date: Fri, 22 Jan 2016 11:26:21 +0000
Subject: Re: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <56A211DD.6050009@de.bosch.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On 19.01.2016 17:20, Wolfram Sang wrote:
> So, I started working on the SDHI part. Since Dirk seems to be working on the
> clocks already (thanks!), I evaluated the patches for the mmc-subsystem and
> refactored the subset which gets the basic functionality run. A few cleanups
> were applied, too. The patches are RFC because I want to check one more issue
> (restore clock settings after software reset) and also I need to do Gen2
> regression testing. However, release early, I wanted to show you what I am
> hacking on here.


I've looked over it and from my limited knowledge point of view it looks 
good. Thanks!

I'd say that patches 2/6 and 4/6 are mainly independent on r8a7795 
support and could be sent without RFC.

I'm not sure if my knowledge is enough to give an Acked-by or 
Reviewed-by, though ;)

Best regards

Dirk

