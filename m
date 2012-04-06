From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 06 Apr 2012 00:22:33 +0000
Subject: Re: [PATCH] serial: sh-sci: modify sci_break_ctl()
Message-Id: <4F7E3749.8010209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7D6708.5060500@renesas.com>
In-Reply-To: <4F7D6708.5060500@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/04/05 18:34, Shimoda, Yoshihiro wrote:
> SCIF modules which have SCSPTR can output the break signal.
> This patch supports it.
> 
> This patch tested on sh7757lcr.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/tty/serial/sh-sci.c |   30 ++++++++++++++++++++++++++----
>  1 files changed, 26 insertions(+), 4 deletions(-)

I would like to cancel this patch because I forgot to add serial_sci.h
to the patch.

Best regards,
Yoshihiro Shimoda
