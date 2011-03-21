From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 21 Mar 2011 07:40:48 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdcfb: add blanking support
Message-Id: <AANLkTin0naZTP_DHm_Z311Kn5b914__ZOV=cJ+OyAK4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1298450190-3803-1-git-send-email-gnurou@gmail.com>
In-Reply-To: <1298450190-3803-1-git-send-email-gnurou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 23, 2011 at 5:36 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> Add a blanking callback to the LCDC driver in order to support both
> FBIOBLANK and TIOCLINUX blanking ioctls. LCDC clocks are also released
> if the requested blanking level is superior to FB_BLANK_NORMAL, to allow
> runtime PM to disable the clocks if possible.
>
> Signed-off-by: Alexandre Courbot <gnurou@gmail.com>

I just tried this on the Mackerel board, seems fine to me.

Acked-by: Magnus Damm <damm@opensource.se>
