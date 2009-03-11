From: morimoto.kuninori@renesas.com
Date: Wed, 11 Mar 2009 09:32:51 +0000
Subject: Re: [PATCH] sh: ap325 and Migo-R use new sh_mobile_ceu_info flags
Message-Id: <umybspfp8.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uprgoplg4.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprgoplg4.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> This seems to depend on some stuff in the v4l tree that well presumably
> be merged during the merge window, so I'll apply this once those changes
> hit mainline.

Yes. This patch needs
http://git.kernel.org/?p=linux/kernel/git/mchehab/linux-next.git;a=commit;h73d07a2579eca98159a3ac71a3d0bd7e81cc47

------------------
Author: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date:   Mon Feb 23 12:12:58 2009 -0300

    V4L/DVB (10671): sh_mobile_ceu: SOCAM flags are not platform dependent
    
    sh_mobile_ceu_camera.c support for signal polarity flags isn't platform
    dependent, provide them locally. Only the bus width is implementation
    specific.
    
    Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
    Acked-by: Magnus Damm <damm@igel.co.jp>
    Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>
------------------

Best regards
--
Kuninori Morimoto
 
