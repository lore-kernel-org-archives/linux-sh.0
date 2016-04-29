From: Peter Hurley <peter@hurleysoftware.com>
Date: Fri, 29 Apr 2016 15:42:15 +0000
Subject: Re: [PATCH v2 07/11] serial: sh-sci: Add more Serial Port Control/Data Register documentation
Message-Id: <572380D7.5040709@hurleysoftware.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1461934714-18681-1-git-send-email-geert+renesas@glider.be>
 <1461934714-18681-8-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1461934714-18681-8-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/29/2016 05:58 AM, Geert Uytterhoeven wrote:
> Improve documentation for the SCIFA/SCIFB Serial Port Control and Data
> Registers:
>   - State clearly that the RTS and CTS lines are active-low,
>   - Document the bits related to the serial port's SCK, RXD, and TXD
>     pins.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

