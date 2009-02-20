From: morimoto.kuninori@renesas.com
Date: Fri, 20 Feb 2009 02:33:18 +0000
Subject: Re: [PATCH 2/2] Add support ov772x driver setting to ap325
Message-Id: <uljs1zvkh.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhc3skvqd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Iwamatsu-san

> Please exclude this commit from sh/for-2.6.29.
> Because patces for media/ov772x.h is not yet taken in in 2.6.29-rcX,
> compiling it fails.
> 
> http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/594

I'm so sorry.
Yesterday, soc_camera maintainer (Guennadi) sent pull request to Mauro.
ap325 needs [07/14: ov772x: Add image flip support].

http://www.mail-archive.com/linux-media@vger.kernel.org/msg01778.html

Best regards
--
Kuninori Morimoto
 
