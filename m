From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Sun, 13 Dec 2015 06:42:47 +0000
Subject: Re: [PATCH v2 16/16] serial: sh-sci: Drop the sci_fck clock fallback
Message-Id: <20151213064247.GB16326@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447958173-543-1-git-send-email-geert+renesas@glider.be>
 <1447958173-543-17-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1447958173-543-17-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Nov 19, 2015 at 07:36:13PM +0100, Geert Uytterhoeven wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> All platforms that used to define an sci_fck clock have now switched to
> the fck name. Remove the fallback code.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
