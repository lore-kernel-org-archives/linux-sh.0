From: Peter Hurley <peter@hurleysoftware.com>
Date: Tue, 16 Feb 2016 17:13:24 +0000
Subject: Re: [PATCH] serial: sh-sci: Remove redundant instances of EARLYCON_DECLARE()
Message-Id: <56C358B4.9060908@hurleysoftware.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1455539792-23140-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1455539792-23140-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp

On 02/15/2016 04:36 AM, Geert Uytterhoeven wrote:
> As of commit 2eaa790989e03900 ("earlycon: Use common framework for
> earlycon declarations") it is no longer needer to specify both
> EARLYCON_DECLARE() and OF_EARLYCON_DECLARE().

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

