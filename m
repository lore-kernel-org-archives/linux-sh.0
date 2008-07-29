From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 29 Jul 2008 05:41:18 +0000
Subject: Re: [PATCH] sh7760fb: write colormap value to hardware.
Message-Id: <488EAD7E.1080804@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <486B39E3.60601@renesas.com>
	<20080728180513.GA31478@roarinelk.homelinux.net>
In-Reply-To: <20080728180513.GA31478@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>, Munakata Hisao <munakata.hisao@renesas.com>

Hi, Manuel.

Thank you for your work.
I checked this patch, there was not a problem.

Best regards,
  Nobuhiro

Manuel Lauss wrote:
> The computed color value is never actually written to hardware
> colormap register.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
Acked-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

