From: Chris Brandt <Chris.Brandt@renesas.com>
Date: Mon, 06 Aug 2018 14:18:17 +0000
Subject: RE: [PATCH/RFC 4/4] sh-sci: Derive regshift value from DT compatible value
Message-Id: <TY1PR01MB15621F645BA5AA48C6060F0D8A200@TY1PR01MB1562.jpnprd01.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
 <20180806140755.24087-5-geert+renesas@glider.be>
In-Reply-To: <20180806140755.24087-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hi Geert,

On Monday, August 06, 2018 1, linux-sh-owner@vger.kernel.org wrote:
> Deriving the proper regshift value from the register block size is
> fragile (it may have been rounded up in DT, and the mapping granularity
> is usually PAGE_SIZE anyway), and turned out to be inappropriate for
> earlycon support (the size is not easily available).
> 
> On DT systems, derive it from the compatible value instead.
> This requires adding an entry for RZ/A2 serial ports, which use an
> atypical regshift value.

I had a simple patch to add support for CONFIG_DEBUG_LL for RZ/A2 
because earlycon never worked because of RZ/A2's different register locations.

I'll have to see how things change (better?) with this patch.


Chris
