From: Rob Landley <rob@landley.net>
Date: Sun, 16 Dec 2018 02:22:42 +0000
Subject: Re: [PATCH v4 0/4] serial: sh-sci: Fix fallback to PIO on DMA failure
Message-Id: <c6dd8a4a-234c-ff1e-0d22-7af61dcec427@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
In-Reply-To: <20181213184444.21904-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On 12/13/18 12:44 PM, Geert Uytterhoeven wrote:
> 	Hi Greg, Jiri,
> 
> When submitting a DMA request fails, the sh-sci driver is supposed to
> fall back to PIO.  However, this never really worked due to various
> reasons (sh-sci driver issues and dmaengine framework limitations).

Is it possible to test this under qemu-system-sh4? (Does that emulate the DMA
controller?)

Rob
